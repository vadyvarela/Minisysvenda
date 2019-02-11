import axios from 'axios'

export default () => {
    return axios.create({
        // baseURL: 'http://minisys.innovatmedialab.com:8095'
        baseURL: 'http://localhost:8095'
    })
}