#tag Class
Protected Class BattlenetSocket
Inherits TCPSocket
	#tag Event
		Sub Connected()
		  
		  stdout.Write( "connected, " )
		  
		  Dim mb As New MemoryBlock( 3 )
		  
		  mb.LittleEndian = True // Battlenet uses little-endian
		  mb.UInt8Value( 0 ) = &H81 // Protocol Byte
		  mb.UInt8Value( 1 ) = Me.Investigate // Value to Investigate
		  
		  stdout.Write( "send --> " + App.strToHex( mb.StringValue( 0, mb.Size )) + ", " )
		  
		  Me.Write( mb )
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub DataAvailable()
		  
		  stdout.WriteLine( "got data --> " + App.strToHex( Me.ReadAll() ))
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error()
		  
		  If Me.LastErrorCode = Me.LostConnection Then
		    
		    stdout.WriteLine( "server closed connection" )
		    
		  Else
		    
		    stdout.WriteLine( "socket error #" + Format( Me.LastErrorCode, "-#" ))
		    
		  End If
		  
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		Investigate As UInt16
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Address"
			Visible=true
			Group="Behavior"
			Type="String"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
