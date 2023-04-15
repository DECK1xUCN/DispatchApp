import merge from "lodash.merge";
import flightResolver from "./flights";
import siteResolver from "./sites";

const resolvers = merge({}, flightResolver, siteResolver);

export default resolvers;
