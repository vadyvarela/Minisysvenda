import store from '@/store'
import axios from 'axios'

export default () => {
    return axios.create({
        // baseURL: 'http://minisys.innovatmedialab.com:8095'
        baseURL: 'http://127.0.0.1:8030',
        headers: {
            Authorization: `Bearer ${store.state.token}`
          }
    })
}