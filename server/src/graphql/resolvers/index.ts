import merge from "lodash.merge";
import heliportResolver from "./heliports";
import siteResolver from "./sites";
import flightResolver from "./flights";
import pilotResolver from "./pilots";
import hoistOperatorResolver from "./hoistOperators";
import helicopterResolver from "./helicopters";
import dailyUpdateResolver from "./dailyUpdates";
import dailyReportResolver from "./dailyReports";

const resolvers = merge(
  {},
  flightResolver,
  heliportResolver,
  siteResolver,
  pilotResolver,
  hoistOperatorResolver,
  helicopterResolver,
  dailyUpdateResolver,
  dailyReportResolver
);

export default resolvers;
