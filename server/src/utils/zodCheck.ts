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
