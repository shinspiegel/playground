const baseApiURL = "http://192.168.15.5:9000/api";

const config = {
  color: {
    background: "#fff",
    text: "#111116",
    primary: "#881",
    secondary: "#129",
    accent: "#22f",
    warning: "#f32",
  },
  api: {
    test: `${baseApiURL}/test`,
    register: `${baseApiURL}/access/register`,
    access: `${baseApiURL}/access/login`,
    company: `${baseApiURL}/company`,
    products: `${baseApiURL}/products`,
  },
  storageKeys: {
    user: "USER_DATA",
  },
};

export default config;
