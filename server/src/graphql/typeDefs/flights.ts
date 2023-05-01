import gql from "graphql-tag";

const flightsTypeDefs = gql`
  scalar DateTime

  type Flight {
    id: Int!
    flightNumber: String!
    date: DateTime!
    helicopter: Helicopter!
    pilot: Pilot!
    hoistOperator: HoistOperator!
    site: Site!
    from: Location!
    via: [Location!]!
    to: Location!
    etd: DateTime!
    rotorStart: DateTime!
    atd: DateTime!
    eta: DateTime!
    rotorStop: DateTime!
    ata: DateTime!
    flightTime: Int!
    blockTime: Int!
    delay: Boolean
    delayCode: String
    delayTime: Int
    delayNote: String
    pax: Int
    paxTax: Int
    cargoPP: Int
    hoistCycles: Int
    note: String
    editable: Boolean
    dailyUpdate: DailyUpdate
    dailyReport: DailyReport
  }

  input CreateFlight {
    flightNumber: String!
    date: DateTime!
    helicopterId: Int!
    pilotId: Int!
    hoistOperatorId: Int!
    siteId: Int!
    fromId: Int!
    viaIds: [Int!]!
    toId: Int!
    etd: DateTime!
    rotorStart: DateTime
    atd: DateTime
    eta: DateTime!
    rotorStop: DateTime
    ata: DateTime
    flightTime: Int
    blockTime: Int
    pax: Int
    paxTax: Int
    cargoPP: Int
    hoistCycles: Int
    note: String
    editable: Boolean
  }

  input updateFlight {
    flightNumber: String
    date: DateTime
    helicopterId: Int
    pilotId: Int
    hoistOperatorId: Int
    siteId: Int
    fromId: Int
    viaIds: [Int!]
    toId: Int
    etd: DateTime
    rotorStart: DateTime
    atd: DateTime
    eta: DateTime
    rotorStop: DateTime
    ata: DateTime
    flightTime: Int
    blockTime: Int
    pax: Int
    paxTax: Int
    cargoPP: Int
    hoistCycles: Int
    note: String
    editable: Boolean
  }

  type Mutation {
    createFlight(data: CreateFlight!): Flight!
    updateFlight(id: Int!, data: updateFlight!): Flight!
  }
  type Query {
    flight(id: Int, flightNumber: String): Flight!
    flights(siteId: Int, date: DateTime): [Flight!]!
    flightsBySiteId(siteId: Int!): [Flight!]!
    flightsPerDay(date: DateTime!): [Flight!]!
    flightsWhereDuIsNull: [Flight!]!
    flightsWhereDfrIsNull: [Flight!]!
    flightById(id: Int!): Flight!
    flightByFlightNumber(flightNumber: String!): Flight!
  }
`;
export default flightsTypeDefs;
