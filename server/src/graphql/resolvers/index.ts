import merge from "lodash.merge";
import heliportResolver from "./heliports";
import siteResolver from "./sites";
import flightResolver from "./flights";

const resolvers = merge({}, flightResolver, heliportResolver, siteResolver);

export default resolvers;
