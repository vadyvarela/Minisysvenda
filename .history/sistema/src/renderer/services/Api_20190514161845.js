import axios from 'axios'

export default () => {
    return axios.create({
        // baseURL: 'http://minisys.innovatmedialab.com:8095'
        baseURL: 'http://localhost:8095'
    }
    const isHandlerEnabled = (config={}) => {
        return config.hasOwnProperty('handlerEnabled') && !config.handlerEnabled ? 
          false : true
      }
      )
    
}