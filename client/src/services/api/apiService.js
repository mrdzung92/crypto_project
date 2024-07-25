import axios from 'axios';

const apiClient = axios.create({
  baseURL: process.env.VITE_API_BASE_URL + '/api/', // Sử dụng biến môi trường
  headers: {
    'Content-Type': 'application/json',
  },
});

apiClient.interceptors.request.use(config => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `${token}`;
  }
  return config;
}, error => {
  return Promise.reject(error);
});

apiClient.interceptors.response.use(
  response => response,
  error => {
    console.error('API Error:', error);
    if (error.response.status == 401) {
      alert('未登录或登录超时')
    }
    return Promise.reject(error);
  }
);

export default {
  get(url, params = {}) {
    return apiClient.get(url, { params });
  },
  post(url, data) {
    return apiClient.post(url, data);
  },
  put(url, data) {
    return apiClient.put(url, data);
  },
  delete(url) {
    return apiClient.delete(url);
  },
};