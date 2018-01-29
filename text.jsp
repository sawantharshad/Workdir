<tr id="Attachment Category" style="display: none">
												<td><form id="proposal_attachment"
														name="proposal_attachment" method="post"
														enctype="multipart/form-data">
														<%-- Handling CSRF by Saraswathi --%>
<input id="csrfreqtoken" type=hidden value="<%=session.getAttribute("csrftoken")%>" name="csrfreqtoken"  />	
														<!-- //width being set for IE 7 as note/table occupies as much space as available -->
														<table style="width: 700px">
															<tr>
																<td><table height="30" style="padding: 4px 0 4px 0">
																		<tr>
																			<td><input name="sjUpload" type="button"
																				class="button-green" id="sjUpload" value="Upload"
																				onclick="saveAttachmentCat(event)" /></td>
																		</tr>
																	</table></td>
															</tr>
															<tr>
																<td colspan="2" class="Note">NOTE: <font
																	color="red">Attachments should be ONLY in PDF
																		format.</font>
																<p />
																	<br /> Please attach a self-contained "SCIENTIFIC
																	JUSTIFICATION" as per the guidelines. A brief status
																	report on each previous APPS proposal should be
																	appended to the scientific justification.<br />
																<br /> When your proposal is scheduled, the contents of
																	the cover sheets become public information. Any
																	supporting pages are for refereeing purpose only. <br />
																<br /> <font color="red">File upload size limit
																		is <%= fileSizeLimit %> MB per attachment.
																</font> <br />
																<br />
																</td>

															</tr>
															<tr>
																<td height="30" width="200"><strong><a
																		href="HelpLinks.jsp#sciJustification" target="_blank">Scientific
																			Justification</a></strong>:</td>
																<td><label> <input name="sci_justification"
																		type="file" id="sci_justification"
																		onchange="setAttachmentCatModified()" />&nbsp;&nbsp;*
																</label> &nbsp;&nbsp; <span id="sciLinkDiv"> <%if(inEditMode && proposal.getSciJustification() != null){%>
																		<a
																		href="javascript:viewAttachment('sci', '<%=proposal.getProposalId()%>')"><%=proposal.getSciJustification()%></a>&nbsp;
																		<a
																		href="javascript:delAttachment('sci', '<%=proposal.getProposalId()%>')">Delete</a>
																		<%} %>
																</span></td>
															</tr>

															<tr>
																<td height="30"><strong><a
																		href="HelpLinks.jsp#techJustification" target="_blank">Technical
																			Justification</a></strong>:</td>
																<td><input name="tech_justification" type="file"
																	id="tech_justification"
																	onchange="setAttachmentCatModified()" /> &nbsp;&nbsp;*
																	&nbsp;&nbsp;<span id="techLinkDiv"> <%if(inEditMode && proposal.getTechJustification() != null){%>
																		<a
																		href="javascript:viewAttachment('tech', '<%=proposal.getProposalId()%>')"><%=proposal.getTechJustification()%></a>&nbsp;
																		<a
																		href="javascript:delAttachment('tech', '<%=proposal.getProposalId()%>')">Delete</a>
																		<%} %>
																</span></td>
															</tr>

															<tr>
																<td>&nbsp;</td>
															</tr>

															<tr>
																<!--                        <td height="30"><strong><a href="HelpLinks.jsp#UVIT" target="_blank">UVIT Bright Source List</a></strong>:</td>
                        <td>
                          <input name="uvit_bright_source_catalog" type="file" id="uvit_bright_source_catalog" onchange="setAttachmentCatModified()" />
                          &nbsp;&nbsp;* &nbsp;&nbsp;<span id="uvitCatalogLinkDiv">
                          <-%if(inEditMode && proposal.getUvitBrightSourceCatalog() != null){%>
                          <a href="javascript:viewAttachment('UVITBrightSourceCatalog', '<-%=proposal.getProposalId()%>')"><-%=proposal.getUvitBrightSourceCatalog()%></a>&nbsp;
                          <a href="javascript:delAttachment('UVITBrightSourceCatalog', '<-%=proposal.getProposalId()%>')">Delete</a>
                          <-%} %>
                          </span>
                          </td>-->
																<td>
																	<% int ephLastId = 1;
                                HashMap<String,String> fileIdMap = new HashMap<String, String>();
                                if(proposal.getUvitBscFiles() == null || proposal.getUvitBscFiles().size() == 0)
                                    ephLastId = 1;
                                else{
                                    ephLastId = 0;
                                    //@Saraswathi:Added PreparedStstement
                                            String qString = "SELECT uvit_bsc_file, uvit_bsc_id "
                                                    + "FROM apps.uvitbscattachments "
                                                    + "WHERE proposal_id=?";
                                            ps=conn.prepareStatement(qString);
                                            ps.setString(1,proposal.getProposalId());
                                            rs2 = ps.executeQuery();
                                    while(rs2.next()){
                                        fileIdMap.put(rs2.getString("uvit_bsc_file"), rs2.getString("uvit_bsc_id"));
                                        int tempId = Integer.parseInt(rs2.getString("uvit_bsc_id").substring(8, 9));
                                        if(tempId > ephLastId)
                                            ephLastId = tempId;
                                    }
                                    /* System.out.println("Hidden file no: " + ephLastId); */
                                }
                                
                               
                                
                              
                                     String id = "SELECT payload FROM apps.payloadconfiguration WHERE proposal_id=? and configured_by_proposers=1";
                                            ps1=conn.prepareStatement(id);
                                            ps1.setString(1,proposal.getProposalId());
                                            rs3 = ps1.executeQuery();
                                           	int flag=0;   
                                           
                                    while(rs3.next()){
                                
                                    
                                    	String payload=rs3.getString("payload");
                                    	//out.println("***********************************************"+payload);
                                       
                                    	
                                     
                                     	 if(payload.contains("uvit")){
                                             out.println("!!!!!!It matched:");
                                             flag=1;
                                             
                                     	 }
                                     	 
                                    }
                                    %>  <input type="hidden"
											value="<%=ephLastId%>" id="uvit_bsc_file_no" />
										</td>
									</tr>
									 <tr id="uvitBscTr" class="flag">
										<td height="33" class="heading" valign="top"
											style="padding-top: 10px"><a
											href="HelpLinks.jsp#UVIT" target="_blank"> UVIT
												Bright Source List (one file per target): </a></td>
										<td id="uvitBscTd">
											<table id="uvitBscParentTable">
												<tbody id="uvitBscParentTableTbody">

												</tbody>
											</table> <%if (proposal.getUvitBscFiles() == null || proposal.getUvitBscFiles().size() == 0) {%>
											<script type="text/javascript">
//                                            addAnotherEphemerisFile();
  </script> <%} else if (inEditMode && proposal.getUvitBscFiles().size() > 0) {
      for (int i = 0; i < proposal.getUvitBscFiles().size(); i++) {
  %> <script type="text/javascript">
    addAnotherEphemerisFile("<%=proposal.getUvitBscFiles().get(i)%>",
    "<%=proposal.getProposalId()%>",
    "<%=fileIdMap.get(proposal.getUvitBscFiles().get(i))%>", "uvit_bsc");
  </script> <%    }
  }
  %>
										</td>
									</tr>
									<tr class="flag">
										<td><input type="button"
											onclick="addAnotherEphemerisFile(null, null, null, 'uvit_bsc')"
											value="Add Another UVIT BSC" /></td>
									</tr> 		
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>   <%       
                                    if(flag!=1)
                                	 {
                                    	%><script type="text/javascript">
                                    	//var all=document.getElementsByClassName('flag1')[0];
                                    	var q1=document.getElementsByClassName('flag')[0];
                                    	var q2=document.getElementsByClassName('flag')[1];
                                    	//all.style.display='none';
                                    	q1.style.display='none';
                                    	q2.style.display='none';
                                    	</script>
                                                                     
                                    <%
                                
                               	   
                                	 }
                               
                                      
                                
                                ephLastId = 1;
                                fileIdMap = new HashMap<String, String>();
                                if(proposal.getAstroviewerOutputFiles() == null || proposal.getAstroviewerOutputFiles().size() == 0)
                                    ephLastId = 1;
                                else{
                                    ephLastId = 0;
                                    /* String qString = "SELECT astroviewer_output_file, astroviewer_output_id "
                                            + "FROM apps.astrovieweroutputattachments "
                                            + "WHERE proposal_id='" + proposal.getProposalId() + "'"; */
                                    String qString =  "SELECT astroviewer_output_file, astroviewer_output_id "
                                            + "FROM apps.astrovieweroutputattachments "
                                            + "WHERE proposal_id=?";
                                    ps=conn.prepareStatement(qString);
                                    ps.setString(1,proposal.getProposalId());
                                    rs2 = ps.executeQuery();
                                    
                                    
                                    while(rs2.next()){
                                        fileIdMap.put(rs2.getString("astroviewer_output_file"), rs2.getString("astroviewer_output_id"));
                                        int tempId = Integer.parseInt(rs2.getString("astroviewer_output_id").substring(18, 19));
                                        if(tempId>ephLastId)
                                            ephLastId = tempId;
                                    }
                                    /* System.out.println("Hidden file no: " + ephLastId); */
                                }
                                %> <input type="hidden"
																	value="<%=ephLastId%>" id="astroviewer_output_file_no" />
																</td>
															</tr>
															<tr id="astroviewerOutputTr">
																<td height="33" class="heading" valign="top"
																	style="padding-top: 10px"><strong> <a
																		href="HelpLinks.jsp#astroviewerOutput" target="_blank">Astroviewer
																			Output (one file per target): </a>&nbsp;&nbsp; <!-- <a href="http://172.18.212.104/WebPIMMS_ASTRO" target="_blank">
                                    Output from Software/Visibility Calculator
                                </a> -->
																</strong></td>
																<td id="astroviewerOutputTd">
																	<table id="astroviewerOutputParentTable">
																		<tbody id="astroviewerOutputParentTableTbody">

																		</tbody>
																	</table> <%if (proposal.getAstroviewerOutputFiles() == null || proposal.getAstroviewerOutputFiles().size() == 0) {%>
																	<script type="text/javascript">
                      //                                            addAnotherEphemerisFile();
                              </script> <%} else if (inEditMode && proposal.getAstroviewerOutputFiles().size() > 0) {
                                  for (int i = 0; i < proposal.getAstroviewerOutputFiles().size(); i++) {
                              %> <script type="text/javascript">
                            addAnotherEphemerisFile("<%=proposal.getAstroviewerOutputFiles().get(i)%>",
                            "<%=proposal.getProposalId()%>",
                            "<%=fileIdMap.get(proposal.getAstroviewerOutputFiles().get(i))%>", "astroviewer_output");
                              </script> <%    }
                              }
                              %>
																</td>
																<!--                        <td>
                          <input name="software_output" type="file" id="software_output" onchange="setAttachmentCatModified()" />
                          &nbsp;&nbsp;* &nbsp;&nbsp;<span id="softwareOutputLinkDiv">
                          <-%if(inEditMode && proposal.getSoftwareOutput() != null){%>
                          <a href="javascript:viewAttachment('softwareOutput', '<-%=proposal.getProposalId()%>')"><-%=proposal.getSoftwareOutput()%></a>&nbsp;
                          <a href="javascript:delAttachment('softwareOutput', '<-%=proposal.getProposalId()%>')">Delete</a>
                          <-%} %>
                          </span>
                          </td>-->

															</tr>
															<tr>
																<td><input type="button"
																	onclick="addAnotherEphemerisFile(null, null, null, 'astroviewer_output')"
																	value="Add Another Astroviewer Output File" /></td>
															</tr>



															<tr id="ephemeris_hidden_tr">
																<td>&nbsp;<br />
																<br />
																</td>
																<td>
																	<!--                              <input type="hidden" <-%if(proposal.getEphemerisFiles().isEmpty()){ %> value="1" <-%}else{%> value="<-%=proposal.getEphemerisFiles().size() %>" <-%}%> id="file_no">-->
																	<%
                                ephLastId = 1;
                                fileIdMap = new HashMap<String, String>();
                                if(proposal.getEphemerisFiles() == null || proposal.getEphemerisFiles().size() == 0)
                                    ephLastId = 1;
                                else{
                                    ephLastId = 0;
                                    String qString = "SELECT ephemeris_file, ephemeris_id "
                                            + "FROM apps.ephemerisattachments "
                                            + "WHERE proposal_id=?";
                                    ps=conn.prepareStatement(qString);
                                    ps.setString(1,proposal.getProposalId());
                                    rs2 = ps.executeQuery();
                                    
                                    
                                    while(rs2.next()){
                                        fileIdMap.put(rs2.getString("ephemeris_file"), rs2.getString("ephemeris_id"));
                                        int tempId = Integer.parseInt(rs2.getString("ephemeris_id").substring(9, 10));
                                        if(tempId>ephLastId)
                                            ephLastId = tempId;
                                    }
                                    /* System.out.println("Hidden file no: " + ephLastId); */
                                }
                                %> <input type="hidden"
																	value="<%=ephLastId%>" id="ephemeris_file_no">
																</td>
															</tr>
															<tr id="ephemerisTr">
																<td height="33" class="heading" valign="top"
																	style="padding-top: 10px"><a
																	href="HelpLinks.jsp#ephemeriesFiles" target="_blank">
																		Ephemeris Files: </a></td>

																<td id="ephemerisTableParentTd">
																	<table id="ephemerisParentTable">
																		<tbody id="ephemerisParentTableTbody">

																		</tbody>
																	</table> <!--table id="ephemerisTable">
                                  <!--                                    <tr>
                                                                          <td valign="top">
                                                                                <input name="ephemeris" type="file" id="ephemeris1" onchange="setAttachmentCatModified()" />
                                                                                &nbsp;&nbsp;* &nbsp;&nbsp;<span id="ephemerisLinkDiv1">
                                                                                <-%if(inEditMode && !proposal.getEphemerisFiles().isEmpty()){%>
                                                                                <a href="javascript:viewAttachment('ephemeris1', '<-%=proposal.getProposalId()%>')"><-%=proposal.getEphemerisFiles().get(0) %></a>&nbsp;
                                                                                <a href="javascript:delAttachment('ephemeris1', '<-%=proposal.getProposalId()%>')">Delete</a>
                                                                                <-%} %>
                                                                                </span>
                                                                          </td>
                                                                      </tr>-->
																	<%if (proposal.getEphemerisFiles() == null || proposal.getEphemerisFiles().size() == 0) {%>
																	<script type="text/javascript">
                          //                                            addAnotherEphemerisFile();
                                  </script> <%} else if (inEditMode && proposal.getEphemerisFiles().size() > 0) {
                                      for (int i = 0; i < proposal.getEphemerisFiles().size(); i++) {
                                  %> <script type="text/javascript">
                                addAnotherEphemerisFile("<%=proposal.getEphemerisFiles().get(i)%>",
                                "<%=proposal.getProposalId()%>",
                                "<%=fileIdMap.get(proposal.getEphemerisFiles().get(i))%>", "ephemeris");
                                  </script> <%    }
                                  }
                                  %> <!--/table-->
																</td>
															</tr>
															<tr id="ephemeris_button_tr">
																<td><input type="button"
																	value="Add More Ephemeris Files"
																	onclick="addAnotherEphemerisFile(null, null, null, 'ephemeris')"
																	id="ephemeris_button" disabled><br />
																<br /></td>
															</tr>

															<tr>
																<td height="33" class="heading" colspan="2"><a
																	href="HelpLinks.jsp#timeAllotedBefore" target="_blank">
																		Proposers have been allotted time in Astrosat before </a>
																	<!--                         <input type="checkbox" id="firsttime_proposer" name="firsttime_proposer" value="ftp" onclick="togglePreprintValues()" -->
																	<%--                         <%if(inEditMode && !proposal.getFirsttimeProposer()) { %> checked="checked" <%} %>/> --%>
																	<input type="checkbox" id="firsttime_proposer"
																	name="firsttime_proposer" value="ftp"
																	<%if(inEditMode && !proposal.getFirsttimeProposer()) { %>
																	checked="checked" <%} %> /></td>
															</tr>
															<%--    <tr style="padding-top:30px">
                        <td height="30" style="vertical-align:top"><strong><a href="HelpLinks.jsp#preprints" target="_blank">Related Publications</a> etc</strong>: <br/> (upto 3)</td>
                        <td>
                          <%
                          String preprint1 = proposal.getPreprint1();
                          String preprint2 = proposal.getPreprint2();
                          String preprint3 = proposal.getPreprint3(); 
                          %>                        
                          <input name="pre1" type="file" disabled="disabled" id="pre1" onchange="setAttachmentCatModified()"  style="margin-bottom:5px"/>
                          &nbsp;&nbsp;(Optional) &nbsp;&nbsp;<span id="pre1LinkDiv">
                          <%if(inEditMode &&  !proposal.getFirsttimeProposer() &&  preprint1 != null){%>
                          <a href="javascript:viewAttachment('pre1', '<%=proposal.getProposalId()%>')"><%=preprint1%></a>&nbsp;
                          <a href="javascript:delAttachment('pre1', '<%=proposal.getProposalId()%>')">Delete</a>
                          <%} %>
                          </span><br/>
                          <input name="pre2" type="file" disabled="disabled" id="pre2" onchange="setAttachmentCatModified()"  style="margin-bottom:5px"/>
                          &nbsp;&nbsp;(Optional) &nbsp;&nbsp;<span id="pre2LinkDiv">
                          <%if(inEditMode &&  !proposal.getFirsttimeProposer() && preprint2 != null){%>
                          <a href="javascript:viewAttachment('pre2', '<%=proposal.getProposalId()%>')"><%=preprint2%></a>&nbsp;
                          <a href="javascript:delAttachment('pre2', '<%=proposal.getProposalId()%>')">Delete</a>
                          <%} %>
                          </span><br/>                          
                          <input name="pre3" type="file" disabled="disabled" id="pre3" onchange="setAttachmentCatModified()"  style="margin-bottom:5px"/>
                          &nbsp;&nbsp;(Optional) &nbsp;&nbsp;<span id="pre3LinkDiv">
                          <%if(inEditMode &&  !proposal.getFirsttimeProposer() && preprint3 != null){%>
                          <a href="javascript:viewAttachment('pre3', '<%=proposal.getProposalId()%>')"><%=preprint3%></a>&nbsp;
                          <a href="javascript:delAttachment('pre3', '<%=proposal.getProposalId()%>')">Delete</a>
                          <%} %>
                          </span>                                                    
                        </td>
                      </tr>  
                      <tr>
                        <td colspan="2">&nbsp;
                        </td>
                      </tr>  --%>
															<tr>
																<td class="Note" id="uploadWarnings" colspan="2"
																	style="color: red;"></td>
															</tr>
															<tr>
																<td><table height="30">
																		<tr>
																			<td><input name="sjUpload" type="button"
																				class="button-green" id="sjUpload" value="Upload"
																				onclick="saveAttachmentCat(event)" /></td>
																		</tr>
																	</table></td>
															</tr>
														</table>
													</form></td>
											</tr>
