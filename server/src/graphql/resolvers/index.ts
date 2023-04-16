import merge from "lodash.merge";
import flightResolver from "./flights";
import siteResolver from "./sites";
import locationsResolver from "./locations";
import helicopterResolver from "./helicopters";
import pilotResolver from "./pilots";
import hoistOperatorResolver from "./hoistOperators";

const resolvers = merge(
  {},
  flightResolver,
  siteResolver,
  locationsResolver,
  helicopterResolver,
  pilotResolver,
  hoistOperatorResolver
);

export default resolvers;
