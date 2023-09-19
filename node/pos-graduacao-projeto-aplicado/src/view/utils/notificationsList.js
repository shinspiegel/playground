const notificationsList = [
  { isError: true, id: '00', message: 'Alguma coisa deu errada!' },
  { isError: true, id: 'NOT_IMPLEMENTED', message: 'Erro no servidor, serviço indisponível.' },
  { isError: true, id: 'MISS_MATCH_ID', message: 'Credênciais com problemas de validação.' },
  { isError: true, id: 'EMAIL_NOT_FOUND', message: 'E-mail não encontrado.' },
  { isError: true, id: 'MAIL_01', message: 'E-mail está em uso.' },
  { isError: true, id: 'INVALID_ID', message: 'Credênciais inválidas.' },
  { isError: true, id: 'INVALID_BODY', message: 'Requisição com problemas.' },
  { isError: true, id: 'INVALID_ARGUMENTS', message: 'Requisição com problemas.' },
  { isError: true, id: 'INVALID_TOKEN', message: 'Credênciais inválidas.' },
  { isError: true, id: 'MISSING_TOKEN', message: 'Credênciais inválidas.' },
  { isError: true, id: 'HASH_01', message: 'Senha incorreta.' },
  { isError: true, id: 'ID_01', message: 'Credênciais inválidas.' },

  { isError: true, id: 'FRONT_NAME_01', message: 'Preencha seu nome.' },
  { isError: true, id: 'FRONT_EMAIL_01', message: 'Preencha seu e-mail.' },
  { isError: true, id: 'FRONT_PASSWORD_01', message: 'Preencha sua senha.' },

  { isError: false, id: 'LOGOUT_SUCESS_01', message: 'Logout realizado com sucesso.' },
  { isError: false, id: 'RECOVER_01', message: 'Email de recuperação foi enviado com sucesso.' },
  { isError: false, id: 'USER_UPDATE_01', message: 'Seus dados foram alterados.' },
  { isError: false, id: 'PASSWORD_UPDATE_01', message: 'Sua senha foi alterada com sucesso.' },
];

export default notificationsList;
