<?xml version="1.0" encoding="UTF-8"?>
<!--
 -
 -  $Id$
 -
 -  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
 -  project.
 -
 -  Copyright (C) 1998-2022 OpenLink Software
 -
 -  This project is free software; you can redistribute it and/or modify it
 -  under the terms of the GNU General Public License as published by the
 -  Free Software Foundation; only version 2 of the License, dated June 1991.
 -
 -  This program is distributed in the hope that it will be useful, but
 -  WITHOUT ANY WARRANTY; without even the implied warranty of
 -  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 -  General Public License for more details.
 -
 -  You should have received a copy of the GNU General Public License along
 -  with this program; if not, write to the Free Software Foundation, Inc.,
 -  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
-->
<!DOCTYPE xsl:stylesheet [
<!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
<!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
<!ENTITY foaf "http://xmlns.com/foaf/0.1/">
<!ENTITY bibo "http://purl.org/ontology/bibo/">
<!ENTITY dc "http://purl.org/dc/elements/1.1/">
<!ENTITY sioct "http://rdfs.org/sioc/types#">
<!ENTITY nyt "http://www.nytimes.com/">
<!ENTITY sioc "http://rdfs.org/sioc/ns#">
<!ENTITY vcard "http://www.w3.org/2001/vcard-rdf/3.0#">
<!ENTITY geo "http://www.w3.org/2003/01/geo/wgs84_pos#"> 
<!ENTITY gn "http://www.geonames.org/ontology#">
<!ENTITY gr "http://purl.org/goodrelations/v1#">
<!ENTITY review "http://purl.org/stuff/rev#">
<!ENTITY c "http://www.w3.org/2002/12/cal/icaltzd#">
<!ENTITY tio "http://purl.org/tio/ns#">
]>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:vi="http://www.openlinksw.com/virtuoso/xslt/"
    xmlns:opl="http://www.openlinksw.com/schema/attribution#"
    xmlns:dcterms = "http://purl.org/dc/terms/"
    xmlns:rdf="&rdf;"
    xmlns:rdfs="&rdfs;"
    xmlns:foaf="&foaf;"
    xmlns:bibo="&bibo;"
    xmlns:dc="&dc;"
    xmlns:c="&c;"	
    xmlns:gr="&gr;"	
    xmlns:tio="&tio;"	
    xmlns:nyt="&nyt;"
    xmlns:sioc="&sioc;"
    xmlns:vcard="&vcard;"
    xmlns:sioct="&sioct;"
    xmlns:geo="&geo;"
    xmlns:gn="&gn;"
    xmlns:review="&review;"
    xmlns:oplfq="http://www.openlinksw.com/schemas/foursquare#"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    >

	<xsl:param name="baseUri" />

	<xsl:output method="xml" indent="yes" />

	<xsl:variable name="resourceURL" select="vi:proxyIRI ($baseUri)"/>
	<xsl:variable  name="docIRI" select="vi:docIRI($baseUri)"/>
	<xsl:variable  name="docproxyIRI" select="vi:docproxyIRI($baseUri)"/>

	<xsl:template match="/teamband">
		<rdf:Description rdf:about="{$docproxyIRI}">
			<rdf:type rdf:resource="&bibo;Document"/>
			<sioc:container_of rdf:resource="{$resourceURL}"/>
			<foaf:primaryTopic rdf:resource="{$resourceURL}"/>
			<dcterms:subject rdf:resource="{$resourceURL}"/>
			<dc:title>
				<xsl:value-of select="$baseUri"/>
			</dc:title>
			<owl:sameAs rdf:resource="{$docIRI}"/>
		</rdf:Description>
		<rdf:Description rdf:about="{$resourceURL}">
			<opl:providedBy>
				<foaf:Organization rdf:about="http://www.seatgeek.com#this">
					<foaf:name>Seatgeek</foaf:name>
					<foaf:homepage rdf:resource="http://www.seatgeek.com"/>
				</foaf:Organization>
			</opl:providedBy>
			<rdf:type rdf:resource="&c;Vcalendar"/>
			<dc:title>
				<xsl:value-of select="name"/>
			</dc:title>
			<rdfs:label>
				<xsl:value-of select="name"/>
			</rdfs:label>
			<xsl:if test="string-length(url) &gt; 0">
				<sioc:link rdf:resource="{url}" />
			</xsl:if>
			<xsl:for-each select="events/event">
				<c:component>
					<c:Vevent rdf:about="{vi:proxyIRI ($baseUri, '', id)}">
						<opl:providedBy>
							<foaf:Organization rdf:about="http://www.seatgeek.com#this">
								<foaf:name>Seatgeek</foaf:name>
								<foaf:homepage rdf:resource="http://www.seatgeek.com"/>
							</foaf:Organization>
						</opl:providedBy>					
						<xsl:if test="string-length(title) &gt; 0">
							<c:summary>
								<xsl:value-of select="title"/>
							</c:summary>
							<rdfs:label>
								<xsl:value-of select="title"/>
							</rdfs:label>
						</xsl:if>
						<xsl:if test="string-length(short_title) &gt; 0">
							<c:description>
								<xsl:value-of select="short_title"/>
							</c:description>
						</xsl:if>
						<xsl:if test="string-length(url) &gt; 0">
							<sioc:link rdf:resource="{url}" />
						</xsl:if>
						<xsl:if test="string-length(image_url) &gt; 0">
							<foaf:depiction rdf:resource="{image_url}" />
						</xsl:if>
						<dcterms:created rdf:datatype="&xsd;dateTime">
							<xsl:value-of select="created_at"/>
						</dcterms:created>
						<dcterms:modified rdf:datatype="&xsd;dateTime">
							<xsl:value-of select="updated_at"/>
						</dcterms:modified>
						<c:dtstart>
							<xsl:value-of select="datetime"/>
						</c:dtstart>
						<c:location>
							<vcard:ADR rdf:about="{vi:proxyIRI($baseUri, '', concat('adr_', id))}">
								<opl:providedBy>
									<foaf:Organization rdf:about="http://www.seatgeek.com#this">
										<foaf:name>Seatgeek</foaf:name>
										<foaf:homepage rdf:resource="http://www.seatgeek.com"/>
									</foaf:Organization>
								</opl:providedBy>							
								<foaf:name>
									<xsl:value-of select="venue_name"/>
								</foaf:name>
								<vcard:Street>
									<xsl:value-of select="venue_address"/>
								</vcard:Street>
								<geo:lat rdf:datatype="&xsd;float">
									<xsl:value-of select="latitude"/>
								</geo:lat>
								<geo:long rdf:datatype="&xsd;float">
									<xsl:value-of select="longitude"/>
								</geo:long>
								<rdfs:label>
									<xsl:value-of select="venue_name"/>
								</rdfs:label>
								<xsl:if test="string-length(venue_location) &gt; 0">
									<vcard:Locality>
										<xsl:value-of select="venue_location" />   
									</vcard:Locality>
								</xsl:if>
							</vcard:ADR>
						</c:location>
						<xsl:if test="string-length(lowest_price) &gt; 0">
							<foaf:topic>
								<rdf:Description rdf:about="{vi:proxyIRI ($baseUri, '', concat('lowest_ticket_offer_', id))}">
									<rdf:type rdf:resource="&gr;Offering" />
									<opl:providedBy>
										<foaf:Organization rdf:about="http://www.seatgeek.com#this">
											<foaf:name>Seatgeek</foaf:name>
											<foaf:homepage rdf:resource="http://www.seatgeek.com"/>
										</foaf:Organization>
									</opl:providedBy>
									<gr:name>
										<xsl:value-of select="concat('Lowest Price Offer to ', title)"/>	
									</gr:name>
									<rdfs:label>
										<xsl:value-of select="concat('Lowest Price Offer to ', title)"/>	
									</rdfs:label>									
									<gr:description>
										<xsl:value-of select="concat('Lowest Price Offer to ', short_title)"/>	
									</gr:description>
									<gr:includes>
										<rdf:Description rdf:about="{vi:proxyIRI ($baseUri, '', concat('lowest_ticket_', id))}">
											<opl:providedBy>
												<foaf:Organization rdf:about="http://www.seatgeek.com#this">
													<foaf:name>Seatgeek</foaf:name>
													<foaf:homepage rdf:resource="http://www.seatgeek.com"/>
												</foaf:Organization>
											</opl:providedBy>
											<rdf:type rdf:resource="&tio;Ticket" />
											<rdfs:label>
												<xsl:value-of select="concat('Lowest Price Ticket to ', title)"/>	
											</rdfs:label>
											<dc:title>
												<xsl:value-of select="concat('Lowest Price Ticket to ', title)"/>
											</dc:title>
											<tio:accessTo rdf:resource="{vi:proxyIRI ($baseUri, '', id)}"/>
										</rdf:Description>
									</gr:includes>									
									<gr:hasBusinessFunction rdf:resource="&gr;Sell"/>
									<gr:hasPriceSpecification>
										<gr:UnitPriceSpecification rdf:about="{vi:proxyIRI ($baseUri, '', concat('lowest_price_', id))}">
											<rdfs:label>
												<xsl:value-of select="concat(lowest_price, ' (USD)')"/>	
											</rdfs:label>
											<gr:hasUnitOfMeasurement>C62</gr:hasUnitOfMeasurement>	
											<gr:hasCurrencyValue rdf:datatype="&xsd;float">
												<xsl:value-of select="lowest_price"/>
											</gr:hasCurrencyValue>
											<gr:hasCurrency rdf:datatype="&xsd;string">USD</gr:hasCurrency>
											<gr:priceType rdf:datatype="&xsd;string">Lowest Price</gr:priceType>
										</gr:UnitPriceSpecification>
									</gr:hasPriceSpecification>
								</rdf:Description>
							</foaf:topic>
						</xsl:if>
						<xsl:if test="string-length(average_price) &gt; 0">
							<foaf:topic>
								<rdf:Description rdf:about="{vi:proxyIRI ($baseUri, '', concat('average_ticket_offer_', id))}">
									<rdf:type rdf:resource="&gr;Offering" />
									<opl:providedBy>
										<foaf:Organization rdf:about="http://www.seatgeek.com#this">
											<foaf:name>Seatgeek</foaf:name>
											<foaf:homepage rdf:resource="http://www.seatgeek.com"/>
										</foaf:Organization>
									</opl:providedBy>
									<gr:name>
										<xsl:value-of select="concat('Average Price Offer to ', title)"/>	
									</gr:name>
									<rdfs:label>
										<xsl:value-of select="concat('Average Price Offer to ', title)"/>	
									</rdfs:label>									
									<gr:description>
										<xsl:value-of select="concat('Average Price Offer to ', short_title)"/>	
									</gr:description>
									<gr:includes>
										<rdf:Description rdf:about="{vi:proxyIRI ($baseUri, '', concat('average_ticket_', id))}">
											<opl:providedBy>
												<foaf:Organization rdf:about="http://www.seatgeek.com#this">
													<foaf:name>Seatgeek</foaf:name>
													<foaf:homepage rdf:resource="http://www.seatgeek.com"/>
												</foaf:Organization>
											</opl:providedBy>
											<rdf:type rdf:resource="&tio;Ticket" />
											<rdfs:label>
												<xsl:value-of select="concat('Average Price Ticket to ', title)"/>	
											</rdfs:label>
											<dc:title>
												<xsl:value-of select="concat('Average Price Ticket to ', title)"/>
											</dc:title>
											<tio:accessTo rdf:resource="{vi:proxyIRI ($baseUri, '', id)}"/>
										</rdf:Description>
									</gr:includes>									
									<gr:hasBusinessFunction rdf:resource="&gr;Sell"/>
									<gr:hasPriceSpecification>
										<gr:UnitPriceSpecification rdf:about="{vi:proxyIRI ($baseUri, '', concat('average_price_', id))}">
											<rdfs:label>
												<xsl:value-of select="concat(average_price, ' (USD)')"/>	
											</rdfs:label>
											<gr:hasUnitOfMeasurement>C62</gr:hasUnitOfMeasurement>	
											<gr:hasCurrencyValue rdf:datatype="&xsd;float">
												<xsl:value-of select="average_price"/>
											</gr:hasCurrencyValue>
											<gr:hasCurrency rdf:datatype="&xsd;string">USD</gr:hasCurrency>
											<gr:priceType rdf:datatype="&xsd;string">Average Price</gr:priceType>
										</gr:UnitPriceSpecification>
									</gr:hasPriceSpecification>
								</rdf:Description>
							</foaf:topic>
						</xsl:if>
						<xsl:if test="string-length(highest_price) &gt; 0">
							<foaf:topic>
								<rdf:Description rdf:about="{vi:proxyIRI ($baseUri, '', concat('highest_ticket_offer_', id))}">
									<rdf:type rdf:resource="&gr;Offering" />
									<opl:providedBy>
										<foaf:Organization rdf:about="http://www.seatgeek.com#this">
											<foaf:name>Seatgeek</foaf:name>
											<foaf:homepage rdf:resource="http://www.seatgeek.com"/>
										</foaf:Organization>
									</opl:providedBy>
									<gr:name>
										<xsl:value-of select="concat('Highest Price Offer to ', title)"/>	
									</gr:name>
									<rdfs:label>
										<xsl:value-of select="concat('Highest Price Offer to ', title)"/>	
									</rdfs:label>									
									<gr:description>
										<xsl:value-of select="concat('Highest Price Offer to ', short_title)"/>	
									</gr:description>
									<gr:includes>
										<rdf:Description rdf:about="{vi:proxyIRI ($baseUri, '', concat('highest_ticket_', id))}">
											<opl:providedBy>
												<foaf:Organization rdf:about="http://www.seatgeek.com#this">
													<foaf:name>Seatgeek</foaf:name>
													<foaf:homepage rdf:resource="http://www.seatgeek.com"/>
												</foaf:Organization>
											</opl:providedBy>
											<rdf:type rdf:resource="&tio;Ticket" />
											<rdfs:label>
												<xsl:value-of select="concat('Highest Price Ticket to ', title)"/>	
											</rdfs:label>
											<dc:title>
												<xsl:value-of select="concat('Highest Price Ticket to ', title)"/>
											</dc:title>
											<tio:accessTo rdf:resource="{vi:proxyIRI ($baseUri, '', id)}"/>
										</rdf:Description>
									</gr:includes>									
									<gr:hasBusinessFunction rdf:resource="&gr;Sell"/>
									<gr:hasPriceSpecification>
										<gr:UnitPriceSpecification rdf:about="{vi:proxyIRI ($baseUri, '', concat('highest_price_', id))}">
											<rdfs:label>
												<xsl:value-of select="concat(highest_price, ' (USD)')"/>	
											</rdfs:label>
											<gr:hasUnitOfMeasurement>C62</gr:hasUnitOfMeasurement>	
											<gr:hasCurrencyValue rdf:datatype="&xsd;float">
												<xsl:value-of select="highest_price"/>
											</gr:hasCurrencyValue>
											<gr:hasCurrency rdf:datatype="&xsd;string">USD</gr:hasCurrency>
											<gr:priceType rdf:datatype="&xsd;string">Highest Price</gr:priceType>
										</gr:UnitPriceSpecification>
									</gr:hasPriceSpecification>
								</rdf:Description>
							</foaf:topic>
						</xsl:if>
					</c:Vevent>
				</c:component>
			</xsl:for-each>
		</rdf:Description>
	</xsl:template>

	<xsl:template match="text()|@*"/>

</xsl:stylesheet>
