import merge from "lodash.merge";
import flightResolver from "./flights";
import siteResolver from "./sites";
import locationsResolver from "./locations";

const resolvers = merge({}, flightResolver, siteResolver, locationsResolver);

export default resolvers;
