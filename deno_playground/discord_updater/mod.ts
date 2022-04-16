/**
 * This is a small script to update the discord message without me touching it.
 * The idea behind this one is to be run once on every time the terminal starts,
 * lets see about it.
 */

// CONSTANTS VALUES
const CONTENT_TYPE = "application/json";
const USER_AGENT =
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36";
const ENV_VAR = {
  user: "DISCORD_USERNAME",
  pass: "DISCORD_PASSWORD",
  workMessage: "DISCORD_WORKING_MESSAGE",
  defaultMessage: "DISCORD_DEFAULT_MESSAGE",
  defaultEmoji: "DISCORD_DEFAULT_EMOJI",
  workEmoji: "DISCORD_WORKING_EMOJI",
};

// TYPE DEFINITIONS
type Login = { token: string; cookie: string };
type SettingStatus = "dnd" | "idle" | "invisible" | "online";
type GetMessageAndStatus = {
  message: string;
  status: SettingStatus;
  emoji_name: string;
};
type DiscordStatus = {
  locale: string;
  status: SettingStatus;
  custom_status: {
    text: string;
    expires_at: number | null;
    emoji_name: number | null;
  };
};
type UpdateMessageOptions = {
  token: string;
  text?: string;
  status?: SettingStatus;
  emoji_name?: string;
};

// BIG MAIN FUNCTION
async function main() {
  dotEnv();
  const { token } = await login();
  const { status, custom_status } = await getStatus(token);

  const now = new Date();
  const hour = now.getHours();
  const weekDay = now.getDay();

  const workMessage = Deno.env.get(ENV_VAR.workMessage);
  const workEmoji = Deno.env.get(ENV_VAR.workEmoji);
  const defaultMessage = Deno.env.get(ENV_VAR.defaultMessage);
  const defaultEmoji = Deno.env.get(ENV_VAR.defaultEmoji);

  const isWeekend = weekDay === 0 || weekDay === 6;
  const isWorkingHours = hour > 8 && hour < 17;
  const isWorkingState = custom_status.text === workMessage && status === "dnd";

  if (!isWeekend && isWorkingHours && !isWorkingState) {
    updateMessage({
      token,
      text: workMessage,
      status: "dnd",
      emoji_name: workEmoji,
    });
    return;
  }

  if ((isWeekend || !isWorkingHours) && isWorkingState) {
    updateMessage({
      token,
      status: "online",
      text: defaultMessage,
      emoji_name: defaultEmoji,
    });
  }
}

// SUPPORT FUNCTIONS
/**
 * This will read the '.env' file and add all the variables on the deno
 * environments variables
 */
function dotEnv() {
  try {
    const dotEnvPath = Deno.cwd() + "/.env";

    const raw = Deno.readTextFileSync(dotEnvPath);
    const data = raw.split("\n").map((d) => {
      const [key, ...value] = d.trim().split("=");
      return { key, value: value.join("=") };
    });

    data.forEach((d) => {
      if (d.key !== "" && d.value && d.value !== "") {
        Deno.env.set(d.key, d.value);
      }
    });
  } catch (err) {}
}

/**
 * This will make the login on discord server
 * @returns {Promise<Login>} The login state with a token
 */
async function login(): Promise<Login> {
  const login = Deno.env.get(ENV_VAR.user);
  const password = Deno.env.get(ENV_VAR.pass);

  if (!login || !password) {
    throw new Error(
      `Failed to read the environment variables. Please set '${ENV_VAR.user}' and '${ENV_VAR.pass}'.`
    );
  }

  try {
    const loginBody = {
      login,
      password,
      undelete: false,
      captcha_key: null,
      login_source: null,
      gift_code_sku_id: null,
    };

    const response = await fetch("https://discord.com/api/v9/auth/login", {
      method: "POST",
      headers: { "Content-Type": CONTENT_TYPE, "User-Agent": USER_AGENT },
      body: JSON.stringify(loginBody),
    });

    const cookie = response.headers.get("set-cookie") || "";
    const token = await response.json().then((r) => r.token);

    return { token, cookie };
  } catch (err) {
    console.warn("FAILED TO LOG IN");
    throw err;
  }
}

/**
 * This will update the discord message/status.
 * @param {UpdateMessageOptions} Options
 */
async function updateMessage({
  status,
  token,
  text,
  emoji_name,
}: UpdateMessageOptions) {
  if (!status && !text && !emoji_name) {
    throw new Error(
      "Please set at least one of: 'status', 'message' or 'emoji_name'."
    );
  }

  if (emoji_name && emoji_name?.length > 2) {
    throw new Error("This should be a single char of the emoji.");
  }

  try {
    // deno-lint-ignore no-explicit-any
    const updateBody: any = {};

    if (status) {
      updateBody.status = status;
    }

    if (text || emoji_name) {
      updateBody.custom_status = { expires_at: null };
    }

    if (text) {
      updateBody.custom_status.text = text;
    }

    if (emoji_name) {
      updateBody.custom_status.emoji_name = emoji_name;
    }

    await fetch("https://discordapp.com/api/v9/users/@me/settings", {
      method: "PATCH",
      headers: {
        "Content-Type": CONTENT_TYPE,
        "User-Agent": USER_AGENT,
        Authorization: token,
      },
      body: JSON.stringify(updateBody),
    });
  } catch (err) {
    console.log(err);
    throw err;
  }
}

/**
 * This will fetch the current user status
 * @param {string} token The user level (not API level) json web token provided by the login
 * @returns {Promise<DiscordStatus>}
 */
async function getStatus(token: string): Promise<DiscordStatus> {
  try {
    const res = await fetch(
      "https://discordapp.com/api/v9/users/@me/settings",
      {
        method: "GET",
        headers: {
          "Content-Type": CONTENT_TYPE,
          "User-Agent": USER_AGENT,
          Authorization: token,
        },
      }
    );

    const data: DiscordStatus = await res.json();

    return data;
  } catch (err) {
    console.log(err);
    throw err;
  }
}

// RUN THE BIG MAIN METHOD
main();
