const mockFetch = (responseObject) =>
  jest.fn().mockImplementation((url, request) => {
    const fetchPromise = new Promise((resolve, reject) => {
      resolve({
        ok: true,
        blob: () => {
          const objToResponse = responseObject ? responseObject : request;
          return objToResponse;
        },
        json: () => {
          const objToResponse = responseObject ? responseObject : request;
          return objToResponse;
        },
      });
    });

    return fetchPromise;
  });

export default mockFetch;
