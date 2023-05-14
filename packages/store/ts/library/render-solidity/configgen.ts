import { resolveAbiOrUserType } from ".";
import { formatAndWriteTypescript } from "@latticexyz/common/codegen";
import { StoreConfig } from "../config";
import path from "path";

const getTypeString = (abiOrUserType: string, config: StoreConfig) => {
  if (abiOrUserType in config.enums) {
    return config.enums[abiOrUserType].map((element) => `"${element}"`).join("|");
  }

  const { schemaType } = resolveAbiOrUserType(abiOrUserType, config);

  return `SchemaTypeToPrimitive[${schemaType}]`;
};

export async function configgen(config: StoreConfig, outputBaseDirectory: string) {
  const fullOutputPath = path.join(outputBaseDirectory, `template.ts`);

  const tables = Object.entries(config.tables)
    .map(([key, value]) => {
      if (typeof value.schema === "object") {
        const fields = Object.entries(value.schema)
          .map(([name, entry]) => `${name}: ${getTypeString(entry, config)}`)
          .join(";");
        return `${key}? : {${fields}}`;
      } else {
        return `${key}?: ${getTypeString(value.schema, config)}`;
      }
    })
    .join(";");

  const output = `
  /* Autogenerated file. Do not edit manually. */
  import { SchemaTypeToPrimitive } from "@latticexyz/schema-type";
  
  export type TemplateConfig = Record<string, {${tables}}>;

  export function templateConfig(config: TemplateConfig) {
    return config;
  }`;

  await formatAndWriteTypescript(output, fullOutputPath, "Generated config types");
}
