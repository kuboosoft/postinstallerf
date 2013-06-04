#!/usr/bin/python
import sys, re
import gtk, gobject
import webkit
DEFAULT_URL = 'extensions.gnome.org/' # Change this as you Wish
class SimpleBrowser: # needs GTK, Python, Webkit-GTK (pywebkitgtk)
  def __init__(self):
		self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
		self.window.set_position(gtk.WIN_POS_CENTER_ALWAYS)
		self.window.connect('delete_event', self.close_application)
		self.window.set_default_size(750, 500)
		vbox = gtk.VBox(spacing=5)
		vbox.set_border_width(5)
		self.txt_url = gtk.Entry()
		self.txt_url.connect('activate', self._txt_url_activate)

		# Genero una barra de herramientas
		toolbar = gtk.HBox(spacing=5)
		vbox.pack_start(toolbar,False,False)

		# Agrego el boton "Atras"
		self.btnback = gtk.Button()
		self.btnback.add(gtk.Arrow(gtk.ARROW_LEFT,gtk.SHADOW_OUT))
		self.btnback.connect('clicked',self._go_back)
		toolbar.pack_start(self.btnback,False,False)

		# Agrego el boton "Adelante"
		self.btnforward = gtk.Button()
		self.btnforward.add(gtk.Arrow(gtk.ARROW_RIGHT,gtk.SHADOW_OUT))
		self.btnforward.connect('clicked',self._go_forward)
		toolbar.pack_start(self.btnforward,False,False)

		# Agrego el boton "Actualizar"
		btnrefresh = gtk.Button('Actualizar')
		btnrefresh.connect('clicked',self._refresh)
		toolbar.pack_start(btnrefresh,False,False)

		
		# Agrego el renderer del motor
		self.scrolled_window = gtk.ScrolledWindow()
		self.webview = webkit.WebView()
		self.scrolled_window.add(self.webview)
		vbox.pack_start(self.scrolled_window, fill=True, expand=True)
		self.window.add(vbox)

		# Agrego un alinea de estado, con una etiqueta y una barra de progreso
		self.pbar = gtk.ProgressBar()
		self.status = gtk.Label()
		hbox2 = gtk.HBox(False,0)
		hbox2.pack_start(self.status,False,False)
		hbox2.pack_end(self.pbar,False,False)
		vbox.pack_start(hbox2,False,True)

		# Defino las acciones a realizar segun los eventos del motor html
		self.webview.connect('load-started',self._load_start)
		self.webview.connect('load-progress-changed',self._load_progress_changed)
		self.webview.connect('load-finished',self._load_finished)
		self.webview.connect('title-changed',self._title_changed)
		self.webview.connect('hovering-over-link',self._hover_link)

	def _open_bar_url(self, nada):
		self.open(self.text.get_text())
	def _txt_url_activate(self, entry):
		self._load(entry.get_text())
	def _load(self, url):
		self.webview.open(url)
	def open(self, url):
		# Si la url no tiene el https:// adelante, se lo agrego
		if url[0:7] != "https://":
			url = "https://"+url
		self.txt_url.set_text(url)
		self._load(url)
	def show(self):
		self.window.show_all()
	def close_application(self, widget, event, data=None):
		gtk.main_quit()
	def _load_start(self, view, nadas):
		self.status.set_text('Cargando...')
		self.pbar.set_fraction(0)
	def _load_progress_changed(self, view, prog):
		self.pbar.set_fraction(prog/100.0)
	def _load_finished(self, view, nada):
		self.pbar.set_fraction(0)
		self.status.set_text('Listo')
	def _go_back(self,nada):
		self.webview.go_back()
	def _go_forward(self,nada):
		self.webview.go_forward()
	def _refresh(self,nada):
		self.webview.reload()
	def _title_changed(self,view,frame,title):
		# Actualizo el titulo del navegador, la url en la barra de url y activo/desactivo los botones Adelante y Atras
		self.window.set_title('%s' % title)
		self.text.set_text(frame.get_uri())
		self.btnback.props.sensitive = self.webview.can_go_back()
		self.btnforward.props.sensitive = self.webview.can_go_forward()
	def _hover_link(self,view,frame,url):
		# Si se hace hover sobre un link, pongo en la barra de estado la url hacia la que linkea
		if view and url:
			self.status.set_text(url)
		else:
			self.status.set_text("")

if __name__ == '__main__':
	if len(sys.argv) > 1:
		url = sys.argv[1]
	else:
		url = DEFAULT_URL
gtk.gdk.threads_init()
browser = SimpleBrowser()
browser.open(url)
browser.show()
gtk.main()
