import { Route, createBrowserRouter, createRoutesFromElements } from "react-router-dom";
import { Root } from "./pages/Root";
import { Login } from "./pages/Login";
import { Register } from "./pages/Register";
import { Dashboard } from "./pages/Dashboard";
import { TripId } from "./pages/trips/TripView";
import { Unauthorized } from "./pages/Unauthorized";

export const ROOT = "/";
export const LOGIN = "/login";
export const REGISTER = "/register";
export const UNAUTHORIZE = "/unauthorized";
export const DASHBOARD = "/dashboard";
export const TRIP = "/trips";
export const TRIP_TRIPID = "/trips/:tripId";

export const router = createBrowserRouter(
	createRoutesFromElements(
		<>
			<Route path={ROOT} element={<Root />} />
			<Route path={LOGIN} element={<Login />} />
			<Route path={REGISTER} element={<Register />} />
			<Route path={DASHBOARD} element={<Dashboard />} />
			<Route path={TRIP_TRIPID} element={<TripId />} />
			<Route path={UNAUTHORIZE} element={<Unauthorized />} />
		</>
	)
);
