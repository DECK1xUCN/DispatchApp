import { createGraphQLError } from "graphql-yoga";
import z from "zod";

export const cheeckEmptyString = (input: string) => {
  try {
    z.string().nonempty().parse(input);
  } catch {
    throw createGraphQLError("Name cannot be empty");
  }
  return input;
};

export const checkReg = (input: string) => {
  try {
    z.string().max(10).parse(input);
  } catch {
    throw createGraphQLError(
      "Helicopter Registration must be 10 characters or less"
    );
  }
  return input;
};

export const checkModel = (input: string) => {
  try {
    z.string().max(10).parse(input);
  } catch {
    throw createGraphQLError("Helicopter Model must be 10 characters or less");
  }
  return input;
};

export const checkFlightNumber = (input: string) => {
  try {
    z.string().max(10).parse(input);
  } catch {
    throw createGraphQLError("Flight Number must be 10 characters or less");
  }
  return input;
};

export const checkLocationName = (input: string) => {
  try {
    z.string().nonempty().max(20).parse(input);
  } catch {
    throw createGraphQLError("Location Name must be 50 characters or less");
  }
  return input;
};

export const checkName = (input: string) => {
  try {
    z.string().nonempty().max(4).parse(input);
  } catch {
    throw createGraphQLError(
      "Name must be 4 characters or less and cannot be empty"
    );
  }
  return input;
};

export const checkFlightTime = (input: number) => {
  try {
    z.number().min(0).max(1440).parse(input);
  } catch {
    throw createGraphQLError(
      "Flight Time must be a positive number and cannot exceed 24h"
    );
  }
  return input;
};
