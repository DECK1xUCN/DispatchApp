import z from "zod";

export const validateEmptyString = (value: string) => {
  try {
    z.string().nonempty().parse(value);
  } catch (error) {
    return false;
  }
  return true;
};
