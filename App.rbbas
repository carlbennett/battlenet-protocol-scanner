#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  
		  #pragma Unused args
		  
		  Me.stdoutVersion()
		  
		  Me.BattlenetTargetServer = "useast.battle.net:6112"
		  
		  Dim sock As New BattlenetSocket()
		  
		  sock.Address = NthField( Me.BattlenetTargetServer, ":", 1 )
		  sock.Port = Val( NthField( Me.BattlenetTargetServer, ":", 2 ))
		  
		  stdout.WriteLine( "Target: " + sock.Address + ":" + Format( Sock.Port, "-# " ))
		  
		  Dim i As Integer = 65535
		  While i >= 0
		    
		    stdout.Write( Right( "    " + Format( i, "-#" ), 5 ) + "/65535 (" + Right( "  " + Format( Round( i / 65535 * 100 ), "-#" ), 3 ) + "%) " )
		    
		    sock.Investigate = i
		    sock.Connect()
		    
		    While Not sock.IsConnected And sock.LastErrorCode = sock.NoError
		      App.YieldToNextThread()
		      App.DoEvents( 1 )
		      Sock.Poll()
		    Wend
		    
		    While sock.IsConnected And sock.LastErrorCode = sock.NoError
		      App.YieldToNextThread()
		      App.DoEvents( 1 )
		      Sock.Poll()
		    Wend
		    
		    If sock.LastErrorCode = sock.LostConnection Then
		      i = i - 1
		    End If
		    
		    Sock.Close()
		    
		    App.YieldToNextThread()
		    App.DoEvents( 10 )
		    
		  Wend
		  
		  stdout.WriteLine( "Finished" )
		  
		  Call stdin.ReadLine()
		  
		  Return 0
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub stdoutVersion()
		  
		  stdout.Write( "battlenet protocol scanner " )
		  stdout.Write( Format( Me.MajorVersion, "-#" ) + "." )
		  stdout.Write( Format( Me.MinorVersion, "-#" ) + "." )
		  stdout.Write( Format( Me.BugVersion, "-#" ) + " Build# " )
		  stdout.Write( Format( Me.NonReleaseVersion, "-#" ) )
		  
		  #If DebugBuild Then
		    stdout.Write(" (debug)" )
		  #EndIf
		  
		  stdout.WriteLine( "" )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function strToHex(value As String, delimiter As String = " ") As String
		  
		  Dim buf As String
		  Dim i, j As Integer
		  
		  i = 1
		  j = LenB( value )
		  
		  While i <= j
		    buf = buf + Right( "0" + Hex( AscB( MidB( value, i, 1 ))), 2 )
		    If i < j Then buf = buf + delimiter
		    i = i + 1
		  Wend
		  
		  Return buf
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		BattlenetTargetServer As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="BattlenetTargetServer"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
