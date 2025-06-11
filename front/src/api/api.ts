const BASE_URL = process.env.NEXT_PUBLIC_API_ADDRESS ?? "http://localhost:5001"

export function customFetch(endpoint: string, options: RequestInit) {
  return fetch(`${BASE_URL}${endpoint}`, options)
}
