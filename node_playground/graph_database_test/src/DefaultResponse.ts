export default class DefaultResponse<T> {
  success: boolean = true;
  message: string = "";
  data: T[] = [];
}
