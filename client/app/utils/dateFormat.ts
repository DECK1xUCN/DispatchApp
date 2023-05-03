import dayjs from "dayjs";
import utc from "dayjs/plugin/utc";

dayjs.extend(utc);

export const dateFormat = (date: string | Date) => {
  return dayjs(date).format("DD.MM.YYYY");
};

export const timeFormat = (date: string | Date) => {
  return dayjs.utc(date).format("HH:mm");
};

export const graphqlDateFormat = (date: string | Date) => {
  return dayjs(date).format("YYYY-MM-DD");
};

export const inputDateFormat = (date: string | Date) => {
  return dayjs(date).format("MM/DD/YYYY");
};
