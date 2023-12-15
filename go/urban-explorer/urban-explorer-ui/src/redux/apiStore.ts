import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
import { Trip } from "../type";

export const HOST_API = "localhost";
export const PORT_API = "8080";
export const BASE_API = `http://${HOST_API}:${PORT_API}/api`;
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
			query: (tripId) => `trip/${tripId}`,
		}),

		addPhotoToTrip: builder.mutation<Trip, { tripId: string; body: FormData }>({
			invalidatesTags: [TRIP],
			query: ({ body, tripId }) => ({
				url: `trips/${tripId}/photo/add`,
				method: "POST",
				body,
			}),
		}),
	}),
});

export const {
	useCheckQuery,
	useLoginMutation,
	useTripNewMutation,
	useTripsQuery,
	useTripByIdQuery,
	useAddPhotoToTripMutation,
	//
} = appApi;
