import dailyReportTypeDefs from "./dailyReports";
import dailyUpdateTypeDefs from "./dailyUpdates";
import flightsTypeDefs from "./flights";
import helicopterTypeDefs from "./helicopters";
import hoistOperatorTypeDefs from "./hoistOperators";
import locationsTypeDefs from "./locations";
import pilotsTypeDefs from "./pilots";
import siteTypeDefs from "./sites";

const typeDefs = [
  flightsTypeDefs,
  siteTypeDefs,
  locationsTypeDefs,
  helicopterTypeDefs,
  pilotsTypeDefs,
  hoistOperatorTypeDefs,
  dailyUpdateTypeDefs,
  dailyReportTypeDefs,
];

export default typeDefs;
