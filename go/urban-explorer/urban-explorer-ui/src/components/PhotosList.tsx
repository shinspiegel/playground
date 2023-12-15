import { useParams } from "react-router-dom";
import { PhotoEntry } from "./PhotoEntry";
import { useTripByIdQuery } from "../redux/apiStore";
import { skipToken } from "@reduxjs/toolkit/query";
import { Loading } from "./Loading";

export function PhotosList() {
	const { tripId } = useParams();
	const { data, isLoading, isFetching } = useTripByIdQuery(tripId ?? skipToken);

	if (isLoading || isFetching) {
		return <Loading />;
	}

	if (!data?.photos || data.photos.length <= 0) {
		return <></>;
	}

	return (
		<div>
			<h1>Photos</h1>

			{data?.photos.map((p) => (
				<PhotoEntry key={p.id} item={p} />
			))}
		</div>
	);
}
