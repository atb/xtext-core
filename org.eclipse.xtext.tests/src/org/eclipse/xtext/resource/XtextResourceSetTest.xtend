/*******************************************************************************
 * Copyright (c) 2012, 2020 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.resource

import java.io.File
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.Resource
import org.junit.Test

import static org.junit.Assert.*

abstract class AbstractXtextResourceSetTest extends AbstractResourceSetTest {
	
	override protected XtextResourceSet createEmptyResourceSet()
	
	@Test
	def void testResourcesAreInMap() {
		val rs = createEmptyResourceSet
		
		assertEquals(0, rs.URIResourceMap.size)
		
		val resource = new XtextResource
		resource.URI = URI::createFileURI(new File('foo').absolutePath)
		
		rs.resources += resource
		
		assertEquals(1, rs.URIResourceMap.size)
		
		rs.resources.remove(resource)
		
		assertTrue(resource.eAdapters.empty)
		assertEquals(0, rs.URIResourceMap.size)
	}
	
	@Test
	def void testResourcesAreInMap_02() {
		val rs = createEmptyResourceSet
		
		assertEquals(0, rs.URIResourceMap.size)
		
		val resource = new XtextResource
		resource.URI = URI::createFileURI(new File('foo').absolutePath)
		
		rs.resources += newArrayList(resource)
		
		assertEquals(1, rs.URIResourceMap.size)
		
		rs.resources.remove(resource)
		
		assertTrue(resource.eAdapters.empty)
		assertEquals(0, rs.URIResourceMap.size)
	}
	
	@Test
	def void testResourcesAreInMap_03() {
		val rs = createEmptyResourceSet
		
		assertEquals(0, rs.URIResourceMap.size)
		
		val resource = new XtextResource
		
		rs.resources += resource
		assertEquals(1, rs.URIResourceMap.size)
		assertEquals(resource, rs.URIResourceMap.get(null))
		
		// set the URI
		resource.URI = URI::createFileURI(new File('foo').absolutePath)
		assertEquals(1, rs.URIResourceMap.size)
		assertFalse(rs.URIResourceMap.containsKey(null))
		assertEquals(resource, rs.URIResourceMap.get(resource.URI))
		assertEquals(resource, rs.URIResourceMap.get(rs.URIConverter.normalize(resource.URI)))
		
		// set the URI
		resource.URI = URI::createFileURI(new File('bar').absolutePath)
		assertEquals(1, rs.URIResourceMap.size)
		assertFalse(rs.URIResourceMap.containsKey(null))
		assertEquals(resource, rs.URIResourceMap.get(resource.URI))
		assertEquals(resource, rs.URIResourceMap.get(rs.URIConverter.normalize(resource.URI)))
		
		// set the URI back to null
		resource.URI = null
		assertEquals(1, rs.URIResourceMap.size)
		assertEquals(resource, rs.URIResourceMap.get(null))
		
		// remove the resource
		rs.resources.remove(resource)
		
		assertTrue(resource.eAdapters.empty)
		assertEquals(0, rs.URIResourceMap.size)
	}
	
	@Test
	def void testResourcesAreCleared_01() {
		val rs = createEmptyResourceSet
		
		assertEquals(0, rs.URIResourceMap.size)
		
		val resource = new XtextResource
		resource.URI = URI::createFileURI(new File('foo').absolutePath)
		
		rs.resources += newArrayList(resource)
		assertEquals(1, rs.URIResourceMap.size)
		
		rs.resources.clear
		
		assertTrue(resource.eAdapters.empty)
		assertEquals(0, rs.URIResourceMap.size)
	}
	
	@Test
	def void testResourcesAreClearedWithDeliverFalse_01() {
		val rs = createEmptyResourceSet
		
		assertEquals(0, rs.URIResourceMap.size)
		
		val resource = new XtextResource
		resource.URI = URI::createFileURI(new File('foo').absolutePath)
		
		rs.resources += newArrayList(resource)
		
		assertEquals(1, rs.URIResourceMap.size)
		rs.eSetDeliver(false)
		rs.resources.clear
		
		assertTrue(resource.eAdapters.empty)
		assertEquals(0, rs.URIResourceMap.size)
	}
	
	@Test
	def void testResourcesAreInMapWithNormalizedURI_01() {
		val rs = createEmptyResourceSet
		
		assertEquals(0, rs.URIResourceMap.size)
		
		val resource = new XtextResource
		resource.URI = URI::createURI('/a/../foo')
		
		rs.resources += resource
		
		assertEquals(2, rs.URIResourceMap.size)
		
		rs.resources.remove(resource)
		
		assertTrue(resource.eAdapters.empty)
		assertEquals(0, rs.URIResourceMap.size)
	}
	
	@Test
	def void testResourcesAreInMapWithNormalizedURI_02() {
		val rs = createEmptyResourceSet
		
		assertEquals(0, rs.URIResourceMap.size)
		
		val resource = new XtextResource
		resource.URI = URI::createURI('/a/../foo')
		
		rs.resources += newArrayList(resource)
		
		assertEquals(2, rs.URIResourceMap.size)
		
		rs.resources.remove(resource)
		
		assertTrue(resource.eAdapters.empty)
		assertEquals(0, rs.URIResourceMap.size)
	}
	
	@Test
	def void testResourcesAreInMapWithNormalizedURI_03() {
		val rs = createEmptyResourceSet
		
		assertEquals(0, rs.URIResourceMap.size)
		
		val resource = new XtextResource
		
		rs.resources += resource
		assertEquals(1, rs.URIResourceMap.size)
		assertEquals(resource, rs.URIResourceMap.get(null))
		
		assertEquals(0, rs.getNormalizationMap.size)
		
		// set the URI
		resource.URI = URI::createURI('/a/../foo')
		assertEquals(2, rs.URIResourceMap.size)
		assertFalse(rs.URIResourceMap.containsKey(null))
		assertEquals(resource, rs.URIResourceMap.get(resource.URI))
		assertEquals(resource, rs.URIResourceMap.get(rs.URIConverter.normalize(resource.URI)))
		
		assertEquals(1, rs.getNormalizationMap.size)
		assertEquals(rs.URIConverter.normalize(resource.URI), rs.getNormalizationMap.get(resource.URI))
		
		// set the URI
		resource.URI = URI::createURI('/a/../bar')
		assertEquals(2, rs.URIResourceMap.size)
		assertFalse(rs.URIResourceMap.containsKey(null))
		assertEquals(resource, rs.URIResourceMap.get(resource.URI))
		assertEquals(resource, rs.URIResourceMap.get(rs.URIConverter.normalize(resource.URI)))
		
		assertEquals(1, rs.getNormalizationMap.size)
		assertEquals(rs.URIConverter.normalize(resource.URI), rs.getNormalizationMap.get(resource.URI))
		
		// set the URI back to null
		resource.URI = null
		assertEquals(1, rs.URIResourceMap.size)
		assertEquals(resource, rs.URIResourceMap.get(null))
		
		assertEquals(0, rs.getNormalizationMap.size)
		
		// remove the resource
		rs.resources.remove(resource)
		
		assertTrue(resource.eAdapters.empty)
		assertEquals(0, rs.URIResourceMap.size)
		
		assertEquals(0, rs.getNormalizationMap.size)
	}
	
	@Test
	def void testResourcesAreClearedWithNormalizedURI_01() {
		val rs = createEmptyResourceSet
		
		assertEquals(0, rs.URIResourceMap.size)
		
		val resource = new XtextResource
		resource.URI = URI::createURI('/a/../foo')
		
		rs.resources += newArrayList(resource)
		
		assertEquals(2, rs.URIResourceMap.size)
		
		rs.resources.clear
		
		assertTrue(resource.eAdapters.empty)
		assertEquals(0, rs.URIResourceMap.size)
	}
	
	@Test
	def void testResourcesAreClearedWithDeliverFalseWithNormalizedURI_01() {
		val rs = createEmptyResourceSet
		
		assertEquals(0, rs.URIResourceMap.size)
		
		val resource = new XtextResource
		resource.URI = URI::createURI('//a/../foo')
		
		rs.resources += newArrayList(resource)
		
		assertEquals(2, rs.URIResourceMap.size)
		rs.eSetDeliver(false)
		rs.resources.clear
		
		assertTrue(resource.eAdapters.empty)
		assertEquals(0, rs.URIResourceMap.size)
	}
}

class SynchronizedXtextResourceSetTest extends AbstractXtextResourceSetTest {
	
	override protected createEmptyResourceSet() {
		new SynchronizedXtextResourceSet
	}
	
	@Test
	def void testSynchronization() {
		val resourceSet = createEmptyResourceSet as SynchronizedXtextResourceSet
		val Resource.Factory nullFactory = [ uri | 
			val result = new NullResource
			result.URI = uri
			result
		]
		resourceSet.resourceFactoryRegistry.extensionToFactoryMap.put('xmi', nullFactory)
		val threads = newArrayList()
		(1..10).forEach [ i |
			threads.add(new Thread [
				val resources = newArrayList
				for(var int j = 0; j < 5000; j++) {
					val resource = resourceSet.createResource(URI.createURI(i + " " + j + ".xmi"))
					assertNotNull(resource)
					resources += resource
					resource.URI = URI.createURI(resource.getURI + 'b')
				}	
			])
		]
		for (Thread thread : threads) {
			thread.start();
		}

		for (Thread thread : threads) {
			thread.join();
		}
		assertEquals(50000, resourceSet.resources.size)
		assertEquals(resourceSet.resources.toSet.size, resourceSet.URIResourceMap.values.toSet.size)
		assertEquals(resourceSet.resources.map[ #[getURI, resourceSet.URIConverter.normalize(URI) ] ].flatten.toSet, resourceSet.URIResourceMap.keySet)
		assertEquals(resourceSet.resources.map[ getURI.toString ].toList.sort.join('\n'), resourceSet.getNormalizationMap.keySet.map[toString].toList.sort.join('\n'))
	}
	
}