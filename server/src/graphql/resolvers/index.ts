import merge from "lodash.merge";
import flightResolver from "./Flights/flights";

const resolvers = merge({}, flightResolver);

export default resolvers;
