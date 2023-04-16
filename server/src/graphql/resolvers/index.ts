import merge from "lodash.merge";
import flightResolver from "./flights";
import siteResolver from "./sites";
import locationsResolver from "./locations";
import helicopterResolver from "./helicopters";
import pilotResolver from "./pilots";
import hoistOperatorResolver from "./hoistOperators";
import dailyUpdateResolver from "./dailyUpdates";
import dailyReportResolver from "./dailyReports";

const resolvers = merge(
  {},
  flightResolver,
  siteResolver,
  locationsResolver,
  helicopterResolver,
  pilotResolver,
  hoistOperatorResolver,
  dailyUpdateResolver,
  dailyReportResolver
);

export default resolvers;
