  LDA #$01
  STA $4016
  LDA #$00
  STA $4016

ReadA:
  LDA $4016       ; Player 1 - A
  AND #%00000001
  BEQ FallingTime

  LDA creditsScreen
  CMP #$00
  BEQ .DoneCheckingCredits

  JMP RESET

.DoneCheckingCredits:

  LDA gameOver
  CMP #$00
  BEQ .DoneCheckingGameOver

  JMP RESET

.DoneCheckingGameOver:

  LDA gameWin
  CMP #$00
  BEQ .DoneCheckingGameWin

  JMP RESET

.DoneCheckingGameWin:

  LDA introDialog
  CMP #$01
  BEQ AdvanceDialog

  LDA #$01
  STA jumping
  JMP ReadADone

FallingTime:
  LDA #$01
  STA falling

  LDA #$00
  STA dialogDelay

  JMP ReadADone

AdvanceDialog:
  LDA endOfDialog
  CMP #$01
  BEQ DialogComplete

  LDA #$01
  STA advanceDialog
  JMP ReadADone

DialogComplete:
  LDA #$00
  STA introDialog
  LDA #$01
  STA introScene2

ReadADone:

ReadB:
  LDA $4016       ; Player 1 - B
  AND #%00000001
  BEQ .ReleaseButton

  LDA #$01
  STA buttonPressedB

  LDA buttonBReleased
  BNE .CanFireProjectile

  JMP ReadBDone

.CanFireProjectile:
  LDA #$00
  STA buttonBReleased

  LDA firingProjectile
  BEQ StartFiringProjectile

  LDA firingProjectile2
  BEQ StartFiringProjectile2

  JMP ReadBDone

.ReleaseButton:
  LDA #$00
  STA buttonPressedB

  LDA #$01
  STA buttonBReleased

  JMP ReadBDone

StartFiringProjectile:
  LDA #$01
  STA firingProjectile

  LDA #$01
  STA buttonPressedB

  LDA playerSprite1Y
  TAX
  LDA projectileY
  TXA
  CLC
  ADC #$08
  STA projectileY

  LDA playerSprite1Attr
  CMP #%01000011
  BEQ .FacingLeft

  LDA #$86
  STA playerSprite6Tile
  LDA #$87
  STA playerSprite9Tile

  LDA playerSprite1X
  TAX
  LDA projectileX
  TXA
  CLC
  ADC #$18
  STA projectileX
  JMP ReadBDone
.FacingLeft:
  LDA #$86
  STA playerSprite4Tile
  LDA #$87
  STA playerSprite7Tile

  LDA playerSprite1X
  TAX
  LDA projectileX
  TXA
  SEC
  SBC #$08
  STA projectileX
  JMP ReadBDone

StartFiringProjectile2:
  LDA #$01
  STA firingProjectile2

  LDA #$01
  STA buttonPressedB

  LDA playerSprite1Y
  TAX
  LDA projectile2Y
  TXA
  CLC
  ADC #$08
  STA projectile2Y

  LDA playerSprite1Attr
  CMP #%01000011
  BEQ .FacingLeft

  LDA #$86
  STA playerSprite6Tile
  LDA #$87
  STA playerSprite9Tile

  LDA playerSprite1X
  TAX
  LDA projectile2X
  TXA
  CLC
  ADC #$18
  STA projectile2X
  JMP ReadBDone
.FacingLeft:
  LDA #$86
  STA playerSprite4Tile
  LDA #$87
  STA playerSprite7Tile

  LDA playerSprite1X
  TAX
  LDA projectile2X
  TXA
  SEC
  SBC #$08
  STA projectile2X

ReadBDone:

  LDA $4016       ; Player 1 - Select
  LDA $4016       ; Player 1 - Start
  LDA $4016       ; Player 1 - Up
  LDA $4016       ; Player 1 - Down

ReadLeft:
  LDA $4016       ; Player 1 - Left
  AND #%00000001
  BNE CheckMovementEnabledLeft

  JMP ReadLeftDone

CheckMovementEnabledLeft:
  LDA movementEnabled
  CMP #$00
  BNE MovePlayerLeft

  JMP ReadLeftDone

MovePlayerLeft:
  LDA #%01000011  ; Flip character sprite to face left
  STA playerSprite1Attr
  STA playerSprite2Attr
  STA playerSprite3Attr
  STA playerSprite4Attr
  STA playerSprite5Attr
  STA playerSprite6Attr
  STA playerSprite7Attr
  STA playerSprite8Attr
  STA playerSprite9Attr

  LDA #$7F
  STA playerSprite1Tile
  LDA #$7D
  STA playerSprite3Tile
  LDA #$80
  STA playerSprite6Tile
  LDA #$83
  STA playerSprite9Tile

  LDA buttonPressedB
  CMP #$01
  BEQ .IdlePose

  LDA #$82
  STA playerSprite4Tile
  LDA #$85
  STA playerSprite7Tile
  JMP CheckScreenCollisionLeft

.IdlePose:
  LDA #$86
  STA playerSprite4Tile
  LDA #$87
  STA playerSprite7Tile

CheckScreenCollisionLeft:
  LDA playerSprite1X
  TAX
  CPX #$00
  BEQ ReadLeftDone

  LDA playerSprite1X
  SEC
  SBC movementSpeed
  STA playerSprite1X
  STA playerSprite4X
  STA playerSprite7X
  LDA playerSprite2X
  SEC
  SBC movementSpeed
  STA playerSprite2X
  STA playerSprite5X
  STA playerSprite8X
  LDA playerSprite3X
  SEC
  SBC movementSpeed
  STA playerSprite3X
  STA playerSprite6X
  STA playerSprite9X
ReadLeftDone:

ReadRight:
  LDA $4016       ; Player 1 - Right
  AND #%00000001
  BNE CheckMovementEnabledRight

  JMP ReadRightDone

CheckMovementEnabledRight:
  LDA movementEnabled
  CMP #$00
  BNE MovePlayerRight

  JMP ReadRightDone

MovePlayerRight:
  LDA #%00000011  ; Flip character sprite to face right
  STA playerSprite1Attr
  STA playerSprite2Attr
  STA playerSprite3Attr
  STA playerSprite4Attr
  STA playerSprite5Attr
  STA playerSprite6Attr
  STA playerSprite7Attr
  STA playerSprite8Attr
  STA playerSprite9Attr

  LDA #$7D
  STA playerSprite1Tile
  LDA #$7F
  STA playerSprite3Tile
  LDA #$80
  STA playerSprite4Tile
  LDA #$83
  STA playerSprite7Tile

  LDA buttonPressedB
  CMP #$01
  BEQ .IdlePose

  LDA #$82
  STA playerSprite6Tile
  LDA #$85
  STA playerSprite9Tile
  JMP CheckScreenCollisionRight

.IdlePose:
  LDA #$86
  STA playerSprite6Tile
  LDA #$87
  STA playerSprite9Tile

CheckScreenCollisionRight:

  LDA playerSprite1X
  TAX
  CPX #$E8
  BEQ ReadRightDone

  LDA playerSprite1X
  CLC
  ADC movementSpeed
  STA playerSprite1X
  STA playerSprite4X
  STA playerSprite7X
  LDA playerSprite2X
  CLC
  ADC movementSpeed
  STA playerSprite2X
  STA playerSprite5X
  STA playerSprite8X
  LDA playerSprite3X
  CLC
  ADC movementSpeed
  STA playerSprite3X
  STA playerSprite6X
  STA playerSprite9X
ReadRightDone:
