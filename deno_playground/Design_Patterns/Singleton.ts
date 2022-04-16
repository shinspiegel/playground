class RequestServer {
    private static _instance: RequestServer;

    public static instance() {
        if (!RequestServer._instance) {
            RequestServer._instance = new RequestServer();
        }

        return RequestServer._instance;
    }

    public requestQueue: string[] = [];
    private constructor() {}

    makeRequest(url: string) {
        this.requestQueue.push(url);
    }
}

const server1 = RequestServer.instance();

server1.makeRequest("request1");

const server2 = RequestServer.instance();

server2.makeRequest("request2");

console.log(server1.requestQueue);
console.log(server2.requestQueue);
