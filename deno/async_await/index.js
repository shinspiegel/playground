function syncFunc() {
    return "Sync";
}

function promisedFunction() {
    return new Promise((res, rej) => {
        res("Promise");
    });
}

promisedFunction().then((res) => console.log("1", res));

console.log("3", syncFunc());
