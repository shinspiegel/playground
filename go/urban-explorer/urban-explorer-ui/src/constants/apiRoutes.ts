export const HOST = "localhost";
export const PORT = "8080";
export const BASE_API = `http://${HOST}:${PORT}/api`;

export const AUTH_CHECK_API = `${BASE_API}/auth/check`;
export const AUTH_LOGIN_API = `${BASE_API}/auth/login`;
export const PHOTOS_PHOTOID = `${BASE_API}/photos/:photoId`;
export const TRIP_API = `${BASE_API}/trips`;
export const TRIP_NEW_API = `${BASE_API}/trips/new`;
export const TRIP_TRIPID_API = `${BASE_API}/trips/:tripId`;
export const TRIP_TRIPID_PHOTO_ADD = `${BASE_API}/trips/:tripId/photo/add`;
