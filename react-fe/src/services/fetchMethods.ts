// import { Promise } from "bluebird";


interface FetchOptions {
    headers: {
        "Content-Type": string;
        Authorization: string;
    };
    method: string;
    body?: string;
    }

export const fetchWithMethod = async <T>(
  methodName: string,
  url: string,
  data?: T,
  contentType = "application/json"
): Promise<T> => {
  const token = localStorage.getItem("token");

  const fetchOptions: FetchOptions = {
    headers: {
      "Content-Type": contentType,
      Authorization: `Bearer ${token}`
    },
    method: methodName,
    body: data
      ? JSON.stringify(data, <TValue>(_key: string, value: TValue) => value)
      : undefined,
  };

  return fetch(url, fetchOptions).then((res) =>
    res.ok ? (res.json() as T) : Promise.reject(res)
  );
};

export const fetchGet = (apiEndpoint: string) =>
  fetchWithMethod("GET", apiEndpoint);

export const fetchPost = <T>(apiEndpoint: string, data: T) =>
  fetchWithMethod("POST", apiEndpoint, data);

export const fetchPut = <T>(apiEndpoint: string, data: T) =>
  fetchWithMethod("PUT", apiEndpoint, data);

export const fetchDelete = (apiEndpoint: string) =>
  fetchWithMethod("DELETE", apiEndpoint);

export const fetchPatch = <T>(apiEndpoint: string, data: T) =>
  fetchWithMethod("PATCH", apiEndpoint, data);
