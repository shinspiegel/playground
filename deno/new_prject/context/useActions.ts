import { useContext } from "react";
import { AppContext, iContextType } from "./index.tsx";
import { cases } from "./reducer.ts";

const useActions = () => {
    const { dispatch, state } = useContext(AppContext) as iContextType;

    const countUp = () => {
        dispatch({ type: cases.count, payload: state.count + 1 });
    };

    return {
        state,
        countUp,
    };
};

export default useActions;
