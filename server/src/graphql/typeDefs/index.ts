import merge from "lodash.merge";
import flightResolver from "./flights";

const resolvers = merge({}, flightResolver);

export default resolvers;
