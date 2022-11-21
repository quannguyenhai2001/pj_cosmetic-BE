var instance = axios.create({
    baseURL: 'http://localhost/api',
});
instance.interceptors.request.use((req) => {
    if (localStorage.getItem('token')) {
        req.headers.Authorization = `Bearer ${localStorage.getItem('token')}`
    }
    return req
})
export default function CallApiByBody(endpoint, method = "GET", body) {
    return instance({
        url: endpoint,
        method: method,
        data: body
    })
}