//import { app, BrowserWindow } from 'electron'
const {app, BrowserWindow, Menu} = require('electron');
/**
 * Set `__static` path to static files in production
 * https://simulatedgreg.gitbooks.io/electron-vue/content/en/using-static-assets.html
 */
if (process.env.NODE_ENV !== 'development') {
  global.__static = require('path').join(__dirname, '/static').replace(/\\/g, '\\\\')
}

// INICIAR SERVIÇO DE IVENDA
require('child_process').exec("C:\\xampp\\htdocs\\ivenda\\ivenda.bat", function (err, stdout, stderr) {
  if (err) {
      return console.log(err);
  }
  // Done.
  console.log(stdout);
});

// // INICIAR PROGRAMA XAMP SERVER
// require('child_process').exec("C:\\xampp\\xampp-control.exe", function (err, stdout, stderr) {
//   if (err) {
//       return console.log(err);
//   }
//   // Done.
//   console.log(stdout);
// });


let mainWindow
const winURL = process.env.NODE_ENV === 'development'
  ? `http://localhost:9080`
  : `file://${__dirname}/index.html`

app.on('ready', () => {
  mainWindow = new BrowserWindow({
    titleBarStyle: 'hidden',
    height: 563,
    useContentSize: true,
    width: 1000,
    show: false
  })

  /*mainWindow.maximize()
  mainWindow.loadURL(winURL)*/

  // create a new `splash`-Window 
  /*splash = new BrowserWindow({width: 810, height: 610, transparent: true, frame: false, alwaysOnTop: true});
  splash.loadURL(`file://${__dirname}/splash.html`);*/
  mainWindow.loadURL(winURL);

  mainWindow.on('closed', () => {
    mainWindow = null
  })
  // Construir o nosso proprio menu
  const mainMenu = Menu.buildFromTemplate(menuTemplate);
  Menu.setApplicationMenu(mainMenu);
  mainWindow.once('ready-to-show', () => {
    // splash.destroy()
    mainWindow.maximize()
    mainWindow.show()
  })
})

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  if (mainWindow === null) {
    createWindow()
  }
})

//Menu = array - que contem objetos
const menuTemplate = [
  {
      label: 'Arquivo',
      submenu: [
          {
              label:'Sair',
              //Espresao ternaria
              accelerator: process.platform === 'darwin' ? 'Command+Q' : 'Ctrl+Q',
              click(){
                  // Funçao para sair da aplicação
                  app.quit();
              }
          }
      ]
  }
];
//condicaso para executar diferentes funcoes em plataformas diferentes
// sistema Mac
if(process.platform == 'darwin'){
  //Metodo que adiciona novo item ao nosso array
  menuTemplate.unshift({})
}

if(process.env.NODE_ENV !== 'production'){
  menuTemplate.push({
      label: 'Desenvolvedor',
      submenu: [
          {
              // Recarregar pagina view com Ctrl+r
              role: 'reload'
          },
          {
              label: 'Mostrar inspecionar elemento',
              accelerator: process.platform === 'darwin' ? 'Commando+Alt+I' : 'Ctrl+Shift+I',
              click(item, focusedWindow){
                  focusedWindow.toggleDevTools();
              }
          }
      ]
  })
}

/**
 * Auto Updater
 *
 * Uncomment the following code below and install `electron-updater` to
 * support auto updating. Code Signing with a valid certificate is required.
 * https://simulatedgreg.gitbooks.io/electron-vue/content/en/using-electron-builder.html#auto-updating
 */

/*
import { autoUpdater } from 'electron-updater'

autoUpdater.on('update-downloaded', () => {
  autoUpdater.quitAndInstall()
})

app.on('ready', () => {
  if (process.env.NODE_ENV === 'production') autoUpdater.checkForUpdates()
})
 */
