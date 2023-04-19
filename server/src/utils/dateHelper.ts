import { createGraphQLError } from "graphql-yoga";
import z from "zod";

export const formatDate = (input: string): Date => {
  try {
    z.string().nonempty().parse(input);
    z.date().parse(new Date(input));
  } catch {
    throw createGraphQLError("Invalid date");
  }
  return new Date(input);
};
