import { createGraphQLError } from "graphql-yoga";
import z from "zod";

export const validateEmptyString = (input: string) => {
  try {
    z.string().nonempty().parse(input);
  } catch {
    throw createGraphQLError("Name cannot be empty");
  }
  return input;
};

export const validateReg = (input: string) => {
  try {
    z.string().max(10).parse(input);
  } catch {
    throw createGraphQLError(
      "Helicopter Registration must be 10 characters or less"
    );
  }
  return input;
};

export const validateModel = (input: string) => {
  try {
    z.string().max(10).parse(input);
  } catch {
    throw createGraphQLError("Helicopter Model must be 10 characters or less");
  }
  return input;
};

export const validateFlightNumber = (input: string) => {
  try {
    z.string().max(10).parse(input);
  } catch {
    throw createGraphQLError("Flight Number must be 10 characters or less");
  }
  return input;
};

export const validateLocationName = (input: string) => {
  try {
    z.string().nonempty().max(20).parse(input);
  } catch {
    throw createGraphQLError("Location Name must be 50 characters or less");
  }
  return input;
};

export const validateName = (input: string) => {
  try {
    z.string().nonempty().max(4).parse(input);
  } catch {
    throw createGraphQLError(
      "Name must be 4 characters or less and cannot be empty"
    );
  }
  return input;
};

export const validateFlightTime = (input: number) => {
  try {
    z.number().min(0).max(1440).parse(input);
  } catch {
    throw createGraphQLError(
      "Flight Time must be a positive number and cannot exceed 24h"
    );
  }
  return input;
};
