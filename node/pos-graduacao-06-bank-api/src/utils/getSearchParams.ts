interface ISearchParamsResponse {
  limit: number;
  skip: number;
}

function getSearchParams(): ISearchParamsResponse {
  return { limit: 100, skip: 0 };
}

export default getSearchParams;
