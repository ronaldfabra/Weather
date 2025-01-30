//
//  ConditionDomainMapper.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

class ConditionDomainMapper: Mapper<ConditionDto, ConditionDomainModel> {
    override func mapValue(response: ConditionDto) -> ConditionDomainModel {
        return ConditionDomainModel(text: response.text,
                                    icon: response.icon,
                                    code: response.code)
    }
}
