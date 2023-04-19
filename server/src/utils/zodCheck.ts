import { createGraphQLError } from "graphql-yoga";
import z from "zod";

export const cheeckEmptyString = (input: string) => {
  try {
    z.string().nonempty().parse(input);
  } catch {
    throw createGraphQLError("Name cannot be empty");
  }
};

export const checkStringMax4 = (input: string) => {
  try {
    z.string().max(4).parse(input);
  } catch {
    throw createGraphQLError("Name must be 4 characters or less");
  }
};

export const checkReg = (input: string) => {
  try {
    z.string().max(10).parse(input);
  } catch {
    throw createGraphQLError(
      "Helicopter Registration must be 10 characters or less"
    );
  }
};

export const checkModel = (input: string) => {
  try {
    z.string().max(10).parse(input);
  } catch {
    throw createGraphQLError("Helicopter Model must be 10 characters or less");
  }
};
