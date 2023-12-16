import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
import { Trip } from "../type";

export const HOST_API = "localhost";
export const PORT_API = "8080";
export const BASE_URL = `http://${HOST_API}:${PORT_API}`;
export const BASE_API = `${BASE_URL}/api`;
const CHECK = "Check";
const TRIP = "TRIP";

export const appApi = createApi({
	reducerPath: "app-api",
	tagTypes: [CHECK, TRIP],
	baseQuery: fetchBaseQuery({
		baseUrl: BASE_API,
		credentials: "include",
	}),

	endpoints: (builder) => ({
		check: builder.query<void, void>({
			providesTags: [CHECK],
			query: () => `auth/check`,
		}),

		login: builder.mutation<void, FormData>({
			invalidatesTags: [CHECK, TRIP],
			query: (body) => ({
				url: `auth/login`,
				method: "POST",
				body,
			}),
		}),
		
		logout: builder.mutation<void,void>({
			invalidatesTags: [CHECK, TRIP],
			query: () => ({
				url: `auth/logout`,
				method: "POST"
			})
		}),

		tripNew: builder.mutation<Trip, FormData>({
			invalidatesTags: [CHECK, TRIP],
			query: (body) => ({
				url: `trips/new`,
				method: "POST",
				body,
			}),
		}),

		trips: builder.query<Trip[], void>({
			providesTags: [TRIP],
			query: () => `trips`,
		}),

		tripById: builder.query<Trip, string>({
			providesTags: [TRIP],
			query: (tripId) => `trips/${tripId}?include-photos=true`,
		}),

		addPhotoToTrip: builder.mutation<Trip, { tripId: string; body: FormData }>({
			invalidatesTags: [TRIP],
			query: ({ body, tripId }) => ({
				url: `trips/${tripId}/photo/add`,
				method: "POST",
				body,
			}),
		}),

		deletePhotoById: builder.mutation<void, number>({
			invalidatesTags: [TRIP],
			query: (photoID) => ({
				url: `photos/${photoID}`,
				method: "DELETE",
			}),
		}),

		deleteTrip: builder.mutation<void, string>({
			invalidatesTags: [TRIP],
			query: (tripId) => ({
				url: `trips/${tripId}`,
				method: "DELETE",
			}),
		}),
	}),
});

export const {
	useCheckQuery,
	useLoginMutation,
	useLogoutMutation,
	useTripNewMutation,
	useTripsQuery,
	useTripByIdQuery,
	useAddPhotoToTripMutation,
	useDeletePhotoByIdMutation,
	useDeleteTripMutation,
} = appApi;
