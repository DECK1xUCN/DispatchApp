export type Helicopter = {
  id: number;
  reg: string;
  model: string;
};

export interface CreateHelicopterInput {
  reg: string;
  model: string;
}

export interface UpdateHelicopterInput {
  reg?: string;
  model?: string;
}
