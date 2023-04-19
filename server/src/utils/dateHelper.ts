import { createGraphQLError } from "graphql-yoga";

export const formatDate = (input: string): Date => {
  if (!(new Date(input) instanceof Date && !isNaN(new Date(input).getTime()))) {
    throw createGraphQLError("Invalid date");
  }
  return new Date(input);
};
