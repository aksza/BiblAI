import axios, { AxiosRequestConfig } from 'axios';

interface AxiosFetchOptions {
  method: AxiosRequestConfig['method'];
  url: string;
  data?: any;
}

export const axiosFetch = async <T>(
  { method, url, data }: AxiosFetchOptions,
  contentType = 'application/json'
): Promise<T> => {
  const token = localStorage.getItem('token');

  const headers = {
    'Content-Type': contentType,
    Authorization: `Bearer ${token}`,
  };

  const axiosOptions: AxiosRequestConfig = {
    method,
    url,
    headers,
    data,
  };

  try {
    const response = await axios(axiosOptions);
    return response.data as T;
  } catch (error) {
    return Promise.reject(error);
  }
};

export const axiosGet = (url: string) =>
  axiosFetch({ method: 'GET', url });

export const axiosPost = <T>(url: string, data: T) =>
  axiosFetch({ method: 'POST', url, data });

export const axiosPut = <T>(url: string, data: T) =>
  axiosFetch({ method: 'PUT', url, data });

export const axiosDelete = <T>(url: string, data?: T) =>
  axiosFetch({ method: 'DELETE', url, data });

export const axiosPatch = <T>(url: string, data: T) =>
  axiosFetch({ method: 'PATCH', url, data });
