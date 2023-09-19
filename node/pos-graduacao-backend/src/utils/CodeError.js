class CodeError extends Error {
  /**
   * This is the CodeError constructor that extends Error constructor from JS.
   * @param {Object} config This is the http code number to use. Default 500.
   * @param {Number} config.code This is the http code number to use. Default 500.
   * @param {String} config.id This is the ID for the error. Default 00
   * @param {String} config.message This is the message description for the error.
   */
  constructor({ code, id, message }) {
    super(message);
    this.code = code || 500;
    this.id = id || '00';
    this.message = message || 'Server Error';
  }
}

/**
 * This is the error list.
 */
const errorList = {
  default: { code: 500, id: '00', message: 'Server error' },
  errorName: { code: 500, id: '00', message: 'Server error' },
  notImplemented: { code: 501, id: 'NOT_IMPLEMENTED', message: "This function isn't ready. Contact support.", },
  missMatchId: { code: 400, id: 'MISS_MATCH_ID', message: "Token ID doen't match url user ID" },
  emailNotFound: { code: 400, id: 'EMAIL_NOT_FOUND', message: 'Email not found.' },
  emailAlreadyInUse: { code: 400, id: 'MAIL_01', message: 'Email already in use' },
  invalidId: { code: 400, id: 'INVALID_ID', message: 'Invalid ID' },
  invalidBody: { code: 400, id: 'INVALID_BODY', message: 'Body not found' },
  invalidArguments: { code: 400, id: 'INVALID_ARGUMENTS', message: 'Some of all the request arguments is invalid', },
  invalidToken: { code: 400, id: 'INVALID_TOKEN', message: 'Invalid token received' },
  missingToken: { code: 400, id: 'MISSING_TOKEN', message: 'Missing or invalid token' },
  invalidPassword: { code: 401, id: 'HASH_01', message: 'Invalid password' },
  invalidTokenId: { code: 401, id: 'ID_01', message: 'Invalid ID on token' },
  missMatchCode: { code: 401, id: 'CODE_01', message: 'Missmatch code received.' },
};

module.exports = { CodeError, errorList };
