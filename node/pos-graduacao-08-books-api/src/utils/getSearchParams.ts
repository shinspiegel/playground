import { Request } from 'express';

interface ISearchParamsResponse {
  limit: number;
  skip: number;
}

function getSearchParams(req: Request): ISearchParamsResponse {
  const searchParams: ISearchParamsResponse = { limit: 100, skip: 0 };

  if (req.params.limit) searchParams.limit = Number(req.params.limit);
  if (req.params.skip) searchParams.skip = Number(req.params.skip);

  return searchParams;
}

export default getSearchParams;
