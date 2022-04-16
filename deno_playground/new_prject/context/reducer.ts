import { iDispatch } from "./index.tsx";
import { iState } from "./initialState.ts";

const Reducer = (state: iState, { type, payload }: iDispatch) => {
    switch (type) {
        case cases.count:
            return {
                ...state,
                count: payload,
            };

        default:
            return state;
    }
};

export const cases = {
    count: "COUNT",
};

export default Reducer;
