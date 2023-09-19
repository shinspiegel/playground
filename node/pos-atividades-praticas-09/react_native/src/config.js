const baseApiURL = "http://192.168.15.7:9000/api";

const config = {
  color: {
    background: "#fff",
    text: "#111116",
    primary: "#13f",
    secondary: "#129",
    accent: "#f62",
    warning: "#f32",
  },
  api: {
    test: `${baseApiURL}/test`,
    access: `${baseApiURL}/access/login`,
    company: `${baseApiURL}/company`,
  },
  storageKeys: {
    user: "USER_DATA",
  },
};

export default config;
